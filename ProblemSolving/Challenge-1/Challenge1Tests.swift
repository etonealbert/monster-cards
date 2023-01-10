//
//  Challenge1Tests.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 07/01/23.
//

import XCTest

func floatFormat(number: Float) -> String {
    return String(format: "%.6f", number)
}

class Challenge1Tests: XCTestCase {
    func testCase1() {
        let values = numbersFractionCalculator(numbers: [-4, 3, -9, 0, 4, 1])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.5))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.333333))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.166667))
    }
    
    func testCase2() {
        let values = numbersFractionCalculator(numbers: [
            -10, -9, -8, -7, -6, -5, -4, -3, -2, -1,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.0))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 1.0))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.0))
    }
    
    func testCase3() {
        let values = numbersFractionCalculator(numbers:[10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 1.0))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.0))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.0))
    }
    
    func testCase4() {
        let values = numbersFractionCalculator(numbers: [4, -1, 0])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.333333))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.333333))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.333333))
    }
    
    func testCase5() {
        let values = numbersFractionCalculator(numbers: [
            -100, 100, 0, 0, 0, -100, 100, 0, -100, 100, 100, 0, 0, 0, 0, -100, -100,
            -100, 0, -100, 0, 100, 100, -100, -100, 100, 100, 100, 100, -100, -100,
            -100, -100, 100, 0, 0, 100, 0, 0, -100, -100, -100, -100, -100, -100, 100,
            100, 0, 100, 100, -100, -100, -100, 0, 100, -100, 0, 100, 100, -100, 100,
            -100, 0, -100, -100, 100, 0, 0, -100, 0, -100, -100, 100, -100, 100, 0,
            100, -100, -100, -100, 100, 100, 100, 100, 0, -100, 0, 100, 100, 100, 0,
            -100, -100, 0, 0, 100, 0, -100, 100, 100,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.34))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.38))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.28))
    }
    
    func testCase6() {
        let values = numbersFractionCalculator(numbers: [
            -6, 1, 79, 17, 64, 94, 87, -77, 0, -26, 2, -94, 87, -81, -73, -28, 43, 0,
            -35, 39, -37, -49, -29, 93, 64, 54, 0, -73, -58, -100, 33, -75, -47, 35,
            -7, 0, 52, -37, -99, 58, -23, 70, -52, 18, 0, -79, -38, 45, -61, 45, 51,
            -48, 32, 0, -44, -56, 29, -74, -1, 92, -93, 23, 0, 55, -31, 75, -43, 20,
            19, 58, -4, 0, 59, -80, 18, -74, 81, 63, 62, -92, 0, -23, 7, -91, 22, -1,
            38, -73, 79, 0, -2, 90, 80, 74, -74, -85, -48, 31, 0, -80,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.44))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.833333))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.166667))
    }
    
    func testCase7() {
        let values = numbersFractionCalculator(numbers: [
            0, -67, -74, -38, -72, -53, 0, -13, -95, -91, -100, -59, 0, -10, -68, -71,
            -62, -21, 0, -42, -57, -16, -66, -23, 0, -80, -63, -68, -65, -71, 0, -71,
            -15, -32, -26, -8, 0, -6, -51, -87, -19, -71, 0, -93, -26, -35, -56, -89,
            0, -21, -74, -39, -57, -8, 0, -69, -29, -24, -99, -53, 0, -65, -42, -72,
            -18, -4, 0, -73, -46, -63, -78, -87,
        ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.333333))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.166667))
    }
    
    func testCase8() {
        let values = numbersFractionCalculator(numbers: [
            -76, -33, 0, -37, 39, 0, 33, -10, 0, 57, 59, 0, -14, -57, 0, -96, 45, 0,
            -60, 82, 0, -94, -31, 0, -68, -53, 0, -57, 100, 0, 35, 81, 0, -4, 76, 0,
            15, 60, 0, 2, -85, 0, 16, -70, 0, 62, -25, 0, 4, -89, 0, -79, -80, 0, -23,
            97, 0, 69, -68, 0, -83, -57, 0, 74, 1, 0, -66, 23, 0, 68, -80, 0, 100, 10,
            0, -73, -54, 0, 0, 4, 0, -8, -86, 0, 58, -85, 0, -100, -100, 0, 43, 61, 0,
            61, -86, 0, 24, -95, 0, -54,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.3))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.36))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.34))
    }
    
    func testCase9() {
        let values = numbersFractionCalculator(numbers: [
            -92, -21, -93, -27, -45, -63, 53, 45, 0, 6, -67, 84, 96, 86, 18, 36, 53,
            0, 47, 88, 91, -59, 65, 62, 3, 13, 0, -49, -47, 94, -63, 65, -23, 48, -5,
            0, -10, 67, -23, 19, -11, 46, 80, -83, 0, -40, 74, -63, -20, -72, 98, -72,
            66, 0, -58, -1, 67, -22, 8, -45, 32, -65, 0, -10, -65, -81, -36, -55, -99,
            -18, -82,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.408451))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0.492958))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.098592))
    }
    
    func testCase10() {
        let values = numbersFractionCalculator(numbers: [
            0, 100, 35, 0, 94, 40, 42, 87, 59, 0,
          ])
        
        XCTAssertNotNil(values[.positives])
        XCTAssertEqual(values[.positives], floatFormat(number: 0.7))
        XCTAssertNotNil(values[.negative])
        XCTAssertEqual(values[.negative], floatFormat(number: 0))
        XCTAssertNotNil(values[.zeros])
        XCTAssertEqual(values[.zeros], floatFormat(number: 0.3))
    }
}
