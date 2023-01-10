//
//  Reducer.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import Foundation

typealias Reducer<State, Action> = (State, Action) -> State

let AppReducer: Reducer<AppState, AppActions> = { state, action in
  var mutatingState = state

  switch action {
  case .setSelected(let newSelectedMonster):
      mutatingState.selectedMonster = newSelectedMonster
    
  case .setMonsters(let newMonsters):
      mutatingState.monsters = newMonsters
  }

  return mutatingState
}
