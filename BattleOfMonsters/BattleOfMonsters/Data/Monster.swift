//
//  Monster.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import Foundation

class Monster: Codable, Identifiable {
    var id: String
    var name: String
    var attack: Int
    var defense: Int
    var hp: Int
    var speed: Int
    var type: String
    var imageUrl: URL
}
