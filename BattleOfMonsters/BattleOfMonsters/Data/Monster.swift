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

    init(id: String, name: String, attack: Int, defense: Int, hp: Int, speed: Int, type: String, imageUrl: URL) {
        self.id = id
        self.name = name
        self.attack = attack
        self.defense = defense
        self.hp = hp
        self.speed = speed
        self.type = type
        self.imageUrl = imageUrl
    }
}

