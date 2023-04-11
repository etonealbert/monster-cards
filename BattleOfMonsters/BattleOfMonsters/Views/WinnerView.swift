//
//  WinnerView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 05/01/23.
//

import SwiftUI

struct WinnerView: View {
    var winnerName: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(winnerName.capitalized) wins!")
                .lineLimit(26)
                .font(.system(size: 22, weight: .regular))
                .multilineTextAlignment(.leading)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 61,
                    alignment: .leading
                )
                .padding(.all, 17)
        }
        .frame(width: 350, height: 61)
        .background(Color(hex: "#E1F8FF"))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .shadow(color: .black.opacity(0.25), radius: 4, x: -2, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                    .stroke(.black, lineWidth: 1)
        )
    }
}

#if !TESTING
struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {

        WinnerView(winnerName: "Dead Unicorn")
            .frame(alignment: .center)
    }
}
#endif
