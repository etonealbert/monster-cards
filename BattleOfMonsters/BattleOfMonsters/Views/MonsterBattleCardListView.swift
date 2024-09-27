//
//  MonsterBattleCardListView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct MonsterBattleCardListView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .firstTextBaseline, spacing: 23) {
                MonsterBattleCardView(defaultName: "Player", monster: store.state.selectedMonster)
                    .accessibilityIdentifier("PlayerBattleCard")
                
                MonsterBattleCardView(defaultName: "Computer", monster: store.state.computerMonster)
                    .accessibilityIdentifier("CPUBattleCard")
            }
            .padding(.horizontal, 7)
            .padding(.top, 6)
            .frame(maxWidth: .infinity, minHeight: 355)
        }
        .accessibilityIdentifier("MonsterBattleCardListScrollView")
    }
}

#if !TESTING
struct MonsterBattleCardListView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let monsters = MonsterList().monsters
            
            store.dispatch(.setMonsters(monsters))
            store.dispatch(.setSelected(monsters[0]))
            
            return store
        }()
        
        MonsterBattleCardListView()
            .environmentObject(previewStore)
    }
}
#endif
