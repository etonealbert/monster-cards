//
//  AppStoreExtension.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 07/01/23.
//

import Foundation

extension AppStore {
  static var preview: AppStore {
    AppStore(
      initial: AppState(),
      reducer: AppReducer
    )
  }
}
