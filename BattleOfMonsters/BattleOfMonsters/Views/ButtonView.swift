//
//  ButtonView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var store: AppStore

    let apiClient: APIClient = MockAPIClient()
    
    func isDisabled() -> Bool{
        return store.state.selectedMonster == nil ||  store.state.computerMonster == nil
    }
    
    func buttonColor(disabled: Bool) -> Color? {
        return disabled ?
            Color(hex: "#799A82") :
            Color(hex: "#10782E")
    }

    var body: some View {
      Button (action: startBattle) {
            Text("Start Battle")
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: 56)
        }
        .background(buttonColor(disabled: isDisabled()))
        .foregroundColor(.white)
        .cornerRadius(5)
        .frame(height: 56)
        .disabled(isDisabled())
    }
  
  func startBattle() {
    guard let playerMonster = store.state.selectedMonster,
          let computerMonster = store.state.computerMonster else {
        return
    }
      let url = "http://localhost:8090/battle"
      let requestBody: [String: String] = [
          "monster1Id": playerMonster.id,
          "monster2Id": computerMonster.id
      ]
      apiClient.sendRequest(url: url, method: "POST", body: requestBody, forResource: nil)  { result in
          switch result {
          case .success(let data):
              if let battle = data as? Battle {
                  DispatchQueue.main.async {
                      store.dispatch(.setBattleResult(battle))
                  }
              }
          case .failure(let error):
              print("Battle req failed: \(error)")

          }
          
      }
  }
  
}

#if !TESTING
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let monsters = MonsterList().monsters
            
            store.dispatch(.setMonsters(monsters))
            store.dispatch(.setSelected(monsters[0]))
            
            return store
        }()

        ButtonView()
            .frame(alignment: .center)
            .environmentObject(previewStore)
    }
}
#endif
