//
//  ProgressBarView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 04/01/23.
//

import SwiftUI

struct ProgressBarView: View {
    var title: String
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 4) {
                ScreenTitleView(title: self.title, size: 12, font: .caption)
                
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(hex: "#D9D9D9"))
                    
                    Rectangle().frame(width: min(
                        CGFloat(self.value / 100)*geometry.size.width, geometry.size.width
                    ), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.green))
                    .animation(.linear)
                }
                .cornerRadius(4.0)
                .shadow(color: .black.opacity(0.25), radius: 7, x: 0, y: 1)
            }
        }
        .frame(width: 235, height: 7)
        .padding(.vertical, 8.0)
    }
}

#if !TESTING
struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(title: "HP", value: 40.0)
    }
}
#endif
