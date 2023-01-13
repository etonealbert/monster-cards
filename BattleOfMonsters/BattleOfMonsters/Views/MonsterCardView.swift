//
//  MonsterCardView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import SwiftUI

struct MonsterCardView: View {
    @EnvironmentObject var store: AppStore
    var monster: Monster
    
    init(monster: Monster) {
        self.monster = monster
    }
    
    func isSelected() -> Bool{
        return store.state.selectedMonster?.id == monster.id
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            AsyncImage(url: URL(string: self.monster.imageUrl.absoluteString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 136, height: 99)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            
            Text(self.monster.name)
                .font(.system(size: 16, weight: .regular))
                .frame(alignment: .leading)
        }
        .frame(width: 150, height: 139)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
        .padding([.horizontal, .bottom], 7)
        .padding(.top, 6)
        .scaleEffect(isSelected() ? 1.03 : 1)
        .animation(.linear)
        .onTapGesture {
            if isSelected() {
                store.dispatch(.setSelected(nil))
            } else {
                store.dispatch(.setSelected(monster))
            }
        }
    }
}

#if !TESTING
struct MonsterCardView_Previews: PreviewProvider {

    static var previews: some View {
        let monsters = MonsterList().monsters

        let previewStore: AppStore = {
            let store = AppStore.preview
            store.dispatch(.setMonsters(monsters))
            
            return store
        }()

        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            MonsterCardView(monster: monsters[0])
                .previewLayout(.sizeThatFits)
                .environmentObject(previewStore)
        }
    }
}
#endif
