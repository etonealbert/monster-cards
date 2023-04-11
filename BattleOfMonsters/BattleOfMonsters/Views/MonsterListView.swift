//
//  MonsterListView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct MonsterListView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(store.state.monsters) { monster in
                    MonsterCardView(monster: monster)
                        .accessibilityIdentifier("MonsterCardView-\(monster.id)")

                }
                .accessibilityIdentifier("MonsterCardViewHStackItems")
            }
            .accessibilityIdentifier("MonsterCardViewHStack")
        }
    }
}

#if !TESTING
struct MonsterListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let monsters = MonsterList().monsters
            
            store.dispatch(.setMonsters(monsters))
            
            return store
        }()
        
        MonsterListView()
            .environmentObject(previewStore)
    }
}
#endif
