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
        // TODO
    }

    func testResultSuccessPostBattleTie() {
        // TODO
    }

    func testResultFailPostBattleInvalidBody() {
        // TODO
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
