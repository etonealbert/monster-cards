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
        return store.state.selectedMonster == nil
    }
    
    func buttonColor(disabled: Bool) -> Color? {
        return disabled ?
            Color(hex: "#799A82") :
            Color(hex: "#10782E")
    }

    var body: some View {
        Button {} label: {
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
