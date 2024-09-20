//
//  State.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import Foundation

struct AppState {
    var monsters: [Monster] = []
    var selectedMonster: Monster?
    var computerMonster: Monster?
    var battleResilt: Battle?
}
