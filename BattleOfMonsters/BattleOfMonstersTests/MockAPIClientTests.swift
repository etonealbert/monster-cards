//
//  MockAPIClientTests.swift
//  BattleOfMonstersTests
//
//  Created by Lukas Ferreira on 06/01/23.
//

import XCTest
@testable import BattleOfMonsters

class MockAPIClientTests: XCTestCase {
    var apiClient: APIClient!
    var services = BattleOfMonstersServices()
    
    override func setUp() {
        self.apiClient = MockAPIClient()
    }
    
    func testInvalidURLSendRequest() {
        let expectation = XCTestExpectation(description: "Throw an Error for an invalid URL")

        let url = "http://yourserver.com/invalid"

        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: nil){ (result) in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let resultError):
                XCTAssertEqual(resultError.localizedDescription, "URL does not exist.")
                expectation.fulfill()
            }
        }
    }

    func testResultSuccessGetMonsters() {
        let expectation = XCTestExpectation(description: "Return a list of 5 monsters")

        let url = "http://yourserver.com/monsters"
        
        let forResource = "monsters"
        
        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: forResource){ (result) in
            switch result {
            case .success(let data):
                let monsters = (data as! [Monster])
                XCTAssertEqual(monsters.count, 5)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testResulFailGetMonsters() {
        let expectation = XCTestExpectation(description: "Throw an Error for an invalid file path")

        let url = "http://yourserver.com/monsters"
        
        let forResource = "unknownFile"
        
        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: forResource){ (result) in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let resultError):
                XCTAssertEqual(resultError.localizedDescription, "Data was not retrieved from request")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testResultSuccessPostBattleWithPlayerMonsterAsWinner() {
        // TODO
    }
    
    func testResultSuccessPostBattleWithComputerMonsterAsWinner() {
      let expectation = XCTestExpectation(description: "Return a battle result with computer's monster as winner")

      let url = "http://cake.com/battle"

      let body = [
          "monster1Id": "monster-2",
          "monster2Id": "monster-1"
      ]

      // Mocking the response
      let winnerMonster = Monster(
          id: "monster-2",
          name: "Monster 2",
          attack: 70,
          defense: 50,
          hp: 15,
          speed: 90,
          type: "Type",
          imageUrl: URL(string: "https://cake.com/monster2.png")!
      )

      let battleResult = Battle(winner: winnerMonster, tie: false)

      let responseData = try! JSONEncoder().encode(battleResult)

      URLProtocolMock.requestHandler = { request in
          XCTAssertEqual(request.url?.path, "/battle")
          XCTAssertEqual(request.httpMethod, "POST")
          let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, responseData)
      }

      self.apiClient.sendRequest(url: url, method: "POST", body: body, forResource: nil) { (result) in
          switch result {
          case .success(let data):
              if let battle = data as? Battle {
                  XCTAssertEqual(battle.winner?.id, "monster-2")
                  XCTAssertFalse(battle.tie)
                  expectation.fulfill()
              } else {
                  XCTFail("Expected Battle object")
              }
          case .failure(let error):
              XCTFail("Expected success but got error: \(error)")
          }
      }

      wait(for: [expectation], timeout: 5)
  }

    func testResultSuccessPostBattleTie() {
      let expectation = XCTestExpectation(description: "Return a battle result indicating a tie")

      let url = "http://cake.com/battle"

      let body = [
          "monster1Id": "monster-1",
          "monster2Id": "monster-1"
      ]

      // Mocking the response
      let battleResult = Battle(winner: nil, tie: true)

      let responseData = try! JSONEncoder().encode(battleResult)

      URLProtocolMock.requestHandler = { request in
          XCTAssertEqual(request.url?.path, "/battle")
          XCTAssertEqual(request.httpMethod, "POST")
          let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, responseData)
      }

      self.apiClient.sendRequest(url: url, method: "POST", body: body, forResource: nil) { (result) in
          switch result {
          case .success(let data):
              if let battle = data as? Battle {
                  XCTAssertNil(battle.winner)
                  XCTAssertTrue(battle.tie)
                  expectation.fulfill()
              } else {
                  XCTFail("Expected Battle object")
              }
          case .failure(let error):
              XCTFail("Expected success but got error: \(error)")
          }
      }

      wait(for: [expectation], timeout: 5)
  }

    func testResultFailPostBattleInvalidBody() {
      let expectation = XCTestExpectation(description: "Return an error for invalid request body")

      let url = "http://cake.com/battle"

      // Invalid body (empty dictionary)
      let body: [String: String] = [:]

      // Mocking the response
      let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid request body"])

      URLProtocolMock.requestHandler = { request in
          let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
          throw error
      }

      self.apiClient.sendRequest(url: url, method: "POST", body: body, forResource: nil) { (result) in
          switch result {
          case .success(let value):
              XCTFail("Expected failure but got success with \(value)")
          case .failure(let resultError):
              XCTAssertEqual(resultError.localizedDescription, "Invalid request body")
              expectation.fulfill()
          }
      }

      wait(for: [expectation], timeout: 5)
  }
    
    func testResultFailPostBattleMissingMonster1ID() {
        // TODO
    }
    
    func testResultFailPostBattleMissingMonster2ID() {
        // TODO
    }
    
    func testResultFailPostBattleInvalidMonster1ID() {
        // TODO
    }
    
    func testResultFailPostBattleInvalidMonster2ID() {
        // TODO
    }
    
    func testResultFailPostBattleBothInvalidIDs() {
        // TODO
    }
}
