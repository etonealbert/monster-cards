//
//  MonsterListView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct MonsterListView: View {
    var monsters: [Monster]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(monsters) { monster in
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
            
            let monsters = (Bundle.main.decode("monsters.json") as [Monster])
            
            store.dispatch(.setMonsters(monsters))
            
            return store
        }()
        
        MonsterListView(monsters: previewStore.state.monsters)
            .environmentObject(previewStore)
    }
}
#endif
