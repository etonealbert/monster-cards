//
//  ContentView.swift
//  BattleOfMonsters
//
//  Created by Lukas Ferreira on 03/01/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    let apiClient: APIClient = MockAPIClient()

    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    ScreenTitleView(title: "Battle of Monsters", size: 36, font: .largeTitle)
                        .padding(.bottom, 17)
                        .accessibilityIdentifier("TitleTextView")

                    ScreenTitleView(title: "Select your monster", size: 24, font: .title2)
                        .padding(.bottom, 4)
                        .accessibilityIdentifier("SubTitleTextView")

                    MonsterListView()
                        .padding(.bottom, 24)
                        .accessibilityIdentifier("MonsterListView")

                    MonsterBattleCardListView()
                        .padding(.bottom, 17)
                        .accessibilityIdentifier("MonsterBattleCardListView")

                    if let battleResult = store.state.battleResult {
                        WinnerView(winnerName: battleResult.winner?.name ?? "It's a tie")
                        
                    } else {
                        ButtonView()
                            .accessibilityIdentifier("StartButtonView")
                    }

                    Spacer()
                }
                .padding(.all, 20)
            }
        }
        .preferredColorScheme(.light)
        .onAppear() {
            let url = "http://localhost:8090/monsters"
            
            self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: nil)
            { (result) in
                switch result {
                case .success(let data):
                    let monsters = (data as! [Monster])
                    store.dispatch(.setMonsters(monsters))

                case .failure:
                    store.dispatch(.setMonsters([]))
                }
            }
        }.animation(.spring())
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(
            initial: AppState(),
            reducer: AppReducer
        )
        
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(store)
    }
}
#endif
