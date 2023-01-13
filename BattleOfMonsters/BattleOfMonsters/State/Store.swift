//
//  Store.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import Foundation
import Combine

typealias AppStore = Store<AppState, AppActions>

class Store<State, Action>: ObservableObject {
  @Published private(set) var state: State
  private let reducer: Reducer<State, Action>
  private var subscriptions: Set<AnyCancellable> = []

  init(
    initial: State,
    reducer: @escaping Reducer<State, Action>
  ) {
    self.state = initial
    self.reducer = reducer
  }

  // The dispatch function dispatches an action to the serial queue.
  func dispatch(_ action: Action) {
      DispatchQueue.main.async { [self] in
          self.dispatch(self.state, action)
      }
  }

  // The internal work for dispatching actions
  private func dispatch(_ currentState: State, _ action: Action) {
    // generate a new state using the reducer
    let newState = reducer(currentState, action)
    // Finally set the state to the new state
    state = newState
  }
}
