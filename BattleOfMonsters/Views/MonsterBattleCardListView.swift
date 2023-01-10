//
//  MonsterBattleCardListView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct MonsterBattleCardListView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .firstTextBaseline, spacing: 23) {
                MonsterBattleCardView(defaultName: "Player", monster: nil)
                    .accessibilityIdentifier("PlayerBattleCard")
                
                MonsterBattleCardView(defaultName: "Computer", monster: nil)
                    .accessibilityIdentifier("CPUBattleCard")
            }
            .padding(.horizontal, 7)
            .padding(.top, 6)
            .frame(width: .infinity, height: 355)

            Spacer()
        }
        .accessibilityIdentifier("MonsterBattleCardListScrollView")
    }
}

#if !TESTING
struct MonsterBattleCardListView_Previews: PreviewProvider {
    static var previews: some View {
        MonsterBattleCardListView()
    }
}
#endif
