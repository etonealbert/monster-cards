//
//  Challenge2Tests.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 07/01/23.
//

import XCTest

class Challenge2Tests: XCTestCase {
    func testCase1() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 6, dice2: 6, dice3: 6))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 6, dice2: 6, dice3: 6), 18)
    }
    
    func testCase2() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 5, dice2: 5, dice3: 5))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 5, dice2: 5, dice3: 5), 15)
    }
    
    func testCase3() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 1, dice2: 2, dice3: 3))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 1, dice2: 2, dice3: 3), 3)
    }
    
    func testCase4() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 1, dice2: 2, dice3: 1))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 1, dice2: 2, dice3: 1), 2)
    }
    
    func testCase5() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 3, dice2: 6, dice3: 3))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 3, dice2: 6, dice3: 3), 6)
    }
    
    func testCase6() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 6, dice2: 5, dice3: 4))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 6, dice2: 5, dice3: 4), 6)
    }
    
    func testCase7() {
        XCTAssertNoThrow(try diceFacesCalculator(dice1: 4, dice2: 5, dice3: 6))
        XCTAssertEqual(try? diceFacesCalculator(dice1: 4, dice2: 5, dice3: 6), 6)
    }
    
    func testCase8() {
        XCTAssertThrowsError(try diceFacesCalculator(dice1: 7, dice2: 6, dice3: 5)) { error in
            XCTAssertEqual(error.localizedDescription, DiceError.OutOfRangeException.localizedDescription)
        }
    }
    
    func testCase9() {
        XCTAssertThrowsError(try diceFacesCalculator(dice1: 0, dice2: 6, dice3: 5)) { error in
            XCTAssertEqual(error.localizedDescription, DiceError.OutOfRangeException.localizedDescription)
        }
    }
    
    func testCase10() {
        XCTAssertThrowsError(try diceFacesCalculator(dice1: -1, dice2: 2, dice3: 3)) { error in
            XCTAssertEqual(error.localizedDescription, DiceError.OutOfRangeException.localizedDescription)
        }
    }
}
