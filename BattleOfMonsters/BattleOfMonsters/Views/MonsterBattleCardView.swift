//
//  MonsterBattleCardView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct StatView: View {
    var statName: String
    var value: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statName)
                
            ProgressView(value: value / 100)
            progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "#00FF00") ?? .green))
                .frame(height: 15)
        }
    }
}

struct MonsterBattleCardView: View {
    var defaultName: String
    var monster: Monster?
    
    init(defaultName: String, monster: Monster? = nil) {
        self.defaultName = defaultName
        self.monster = monster
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            if let monster = monster {
                
                AsyncImage(url: URL(string: (self.monster?.imageUrl.absoluteString)!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .background(Color.green)
                .cornerRadius(8)
                .padding(.top, 10)
                
                Text(monster.name)
                    .font(.title)
                    .underline()
                    .padding(.vertical, 5)
                
                VStack(spacing: 2) {
                    StatView(statName: "HP", value: Double(monster.hp))
                    StatView(statName: "Attack", value: Double(monster.attack))
                    StatView(statName: "Defense", value: Double(monster.defense))
                    StatView(statName: "Speed", value: Double(monster.speed))
                }
                
            } else {
                
                VStack(alignment: .leading) {
                    Text(self.defaultName)
                        .font(.system(size: 36, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                }
                
                Spacer()
            }
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
