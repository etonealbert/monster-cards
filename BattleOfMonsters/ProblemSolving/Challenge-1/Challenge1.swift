//
//  Challenge1.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 07/01/23.
//

import Foundation

enum ReturnKeys: String {
case positives = "positives"
case negative = "negative"
case zeros =  "zeros"
}

func numbersFractionCalculator(numbers: [Int]) -> Dictionary<ReturnKeys, String> {
    return [
        .positives: "0.000000",
        .negative: "0.000000",
        .zeros: "0.000000"
    ]
}
