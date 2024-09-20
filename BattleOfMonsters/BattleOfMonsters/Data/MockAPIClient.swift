//
//  MockAPIClient.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 05/01/23.
//

import Foundation
import Combine

protocol APIClient {
    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void)
}

struct MockAPIClient: APIClient {
    private var session: URLSession
    
    init(using session: URLSession = URLSession.shared) {
        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
            // Your code that should run under tests
            // Set url session for mock networking
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [URLProtocolMock.self]
            self.session = URLSession(configuration: configuration)
        } else {
            self.session = session

        }
    }

    func getMonsters(url: URL, forResource: String, completion: @escaping (Result<[Monster], Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
            // Your code that should run under tests
            let services = BattleOfMonstersServices()
            
            services.getMonsters(forResource: forResource){ (result) in
                switch result {
                case .success(let data):
                    URLProtocolMock.requestHandler = { request in
                        return (HTTPURLResponse(), data)
                    }
                case .failure(let error):
                    URLProtocolMock.requestHandler = { request in
                        throw error
                    }
                }
            }
        }

        let task = self.session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let monsterData = data {
                if let monsters = try? JSONDecoder().decode([Monster].self, from: monsterData) {
                    completion(.success(monsters))
                }
            }
            else {
                if let requestError = error {
                    completion(.failure(requestError))
                }
            }
        })

        task.resume()
    }

    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void) {
        let requestURL = URL(string: url)!
        let endpoint = requestURL.path

        switch endpoint {
        case "/monsters":
            getMonsters(url: requestURL, forResource: forResource ?? "monsters"){ (result) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case "/battle":
            var request = URLRequest(url: requestURL)
            request.httpMethod = method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            let task = self.session.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let battle = try? JSONDecoder().decode(Battle.self, from: data) {
                        completion(.success(battle))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed Decode"])))
                    }
                } else if let error = error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            
            
        default:
            completion(.failure(NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "URL does not exist."])))
        }
    }
}
