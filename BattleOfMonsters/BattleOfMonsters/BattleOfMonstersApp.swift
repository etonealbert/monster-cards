//
//  BattleOfMonstersApp.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import SwiftUI

@main
struct BattleOfMonstersApp: App {
    let store = AppStore(initial: AppState(), reducer: AppReducer)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
