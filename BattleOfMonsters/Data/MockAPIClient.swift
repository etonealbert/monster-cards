//
//  MockAPIClient.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 05/01/23.
//

import Foundation

protocol APIClient {
    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void)
}

struct MockAPIClient: APIClient {
    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void) {
        let requestURL = URL(string: url)!
        let endpoint = requestURL.path
        let services = BattleOfMonstersServices()

        switch endpoint {
        case "/monsters":
            services.getMonsters(forResource: forResource ?? "monsters"){ (result) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        default:
            completion(.failure(NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "URL does not exist."])))
        }
    }
}
