//
//  ScreenTitleView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import SwiftUI

struct ScreenTitleView: View {
    var title: String
    var size: Int
    var font: Font

    init(title: String, size: Int, font: Font) {
        self.title = title
        self.size = size
        self.font = font
    }
    
    var body: some View {
        Text(self.title)
            .font(self.font)
            .font(.system(size: CGFloat(self.size), weight: .regular))
            .frame(alignment: .leading)
    }
}

#if !TESTING
struct ScreenTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTitleView(title: "Battle of Monsters", size: 36, font: .title).previewLayout(.sizeThatFits)
    }
}
#endif
