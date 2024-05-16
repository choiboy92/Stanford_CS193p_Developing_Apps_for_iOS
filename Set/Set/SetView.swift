//
//  SetView.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//

import SwiftUI

struct SetView: View {
    //initialise the ViewModel - Reactive UI
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("Set")
                .font(.title)
            Spacer()
            cards
            Spacer()
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .padding(5)
        }
    }
    
    struct CardView: View {
        typealias Card = SetModel.Card
            
        let card: Card
        init(_ card: Card) {
            self.card = card
        }
        
        var body: some View {
            ClassicTheme.CardContent(card.featureState)
                .cardify()
        }
    }
}


#Preview {
    SetView(viewModel: SetViewModel())
}

