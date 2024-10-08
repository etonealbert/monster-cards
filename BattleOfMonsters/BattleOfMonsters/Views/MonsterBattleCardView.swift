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
            if let monster = monster {
                AsyncImage(url: URL(string: (self.monster?.imageUrl.absoluteString)!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .background(Color.green)
                .cornerRadius(8)
                .padding(.top, 10)

  
                Text(monster.name)
                    .font(.title)
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 5)

                VStack(spacing: 3) {
                    StatView(statName: "HP", value: Double(monster.hp))
                    StatView(statName: "Attack", value: Double(monster.attack))
                    StatView(statName: "Defense", value: Double(monster.defense))
                    StatView(statName: "Speed", value: Double(monster.speed))
                }
            } else {
              VStack {
                  Text(defaultName)
                      .font(.largeTitle)
                      .fontWeight(.bold)
                      .frame(maxWidth: .infinity, alignment: .center)
              }
              .frame(maxHeight: .infinity, alignment: .center)
            }

            Spacer()
        }
        .padding(.horizontal, 10)
        .frame(width: 300, height: 400)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
    }
}


struct StatView: View {
    var statName: String
    var value: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text(statName)
                .font(.caption)

            ProgressView(value: value / 100)
            .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "#00FF00") ?? .green))
                .frame(height: 15)
        }
    }
}

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
