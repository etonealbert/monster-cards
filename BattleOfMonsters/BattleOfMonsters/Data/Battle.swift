//
//  Battle.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 05/01/23.
//

import Foundation

class Battle: Codable, Identifiable {
    var id = UUID()

    var winner: Monster?
    var tie: Bool
    
    init(winner: Monster? = nil, tie: Bool) {
        self.winner = winner
        self.tie = tie
    }
}
