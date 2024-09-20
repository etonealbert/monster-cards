//
//  MonsterBattleCardView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct MonsterBattleCardView: View {
    var defaultName: String
    var monster: Monster?
    
    init(defaultName: String, monster: Monster? = nil) {
        self.defaultName = defaultName
        self.monster = monster
    }
    
    var body: some View {
        VStack {
            Text(monster?.name ?? defaultName)
                .font(.headline)
                .padding()

            if let monster = monster {
                Text("Attack: \(monster.attack)")
                Text("Defense: \(monster.defense)")
            } else {
                Text("No monster selected")
            }

            Spacer()
        }
        .frame(width: 255, height: 350)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
    }}

#if !TESTING
struct MonsterBattleCardView_Previews: PreviewProvider {
    static var previews: some View {
        let monsters = MonsterList().monsters

        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            MonsterBattleCardView(
                defaultName: "Player",
                monster: monsters[0]
            )
        }
    }
}
#endif
