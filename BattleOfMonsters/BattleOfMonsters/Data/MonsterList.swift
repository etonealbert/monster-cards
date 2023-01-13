//
//  MonsterList.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import SwiftUI

class MonsterList {
    var monsters: [Monster] = (Bundle.main.decode("monsters.json") as [Monster])
}
