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
      
      if let playerMonster = newSelectedMonster {
          if let randomComputerMonster = mutatingState.monsters.randomElement() {
              mutatingState.computerMonster = randomComputerMonster
          }
      } else {
          mutatingState.computerMonster = nil
      }
    
  case .setMonsters(let newMonsters):
      mutatingState.monsters = newMonsters
  case .setComputerMonster( let newComputerMonster):
      mutatingState.computerMonster = newComputerMonster
  case .setBattleResult(let battleResult):
      mutatingState.battleResult = battleResult
  }

  return mutatingState
}
