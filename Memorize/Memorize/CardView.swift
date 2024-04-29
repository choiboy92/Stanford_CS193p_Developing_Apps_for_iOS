//
//  CardView.swift
//  Memorize
//
//  Created by Junho Choi on 29/04/2024.
//

import SwiftUI

// Build a custom view element
struct CardView: View {
    // Structs have default property initialisers
    
//     let content: String
    // an alias for a type - it is also namespaced so be aware of the scope
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    // needs to be a var as we want it to change
    // var isFaceUp: Bool = false     // stored property needs a value when called
    // @State var isFaceUp = false    // STATE - creates a pointer to this variable for temporary state
    // will get rid of @State when implementing game logic in backend
    
    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        /*
        // PASSED A CLOSURE (A FUNCTION AS AN ARGUMENT)
        ZStack(alignment: .top, content: {
            RoundedRectangle(cornerRadius: 12)
        }
        // THEREFORE CAN REWRITE USING TRAILING CLOSURE SYNTAX:
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
        }
        // IF USING DEFAULT ARGUMENTS, CAN REMOVE PARENTHESES:
        ZStack {
            RoundedRectangle(cornerRadius: 12)
        }
        */
        ZStack() {
            // can create a constant from types
            let base = RoundedRectangle(cornerRadius: 12) // use TYPE INFERENCE
            // equivalent to - let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            // BASE is back of card
            
            // Group is a bag of lego to apply view modifiers to all - FRONT OF CARD
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)      // enable text to scale down to 1/100 of its size
                    .aspectRatio(1, contentMode: .fit)     // expand to fit the parent size (in this case the card)
                    .multilineTextAlignment(.center)
                    .padding(5)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)   // fade out cards that have been matched
    }
}

// CUstom preview of the card component
struct CardView_Previews: PreviewProvider {
    // an alias for a type - it is also namespaced so be aware of the scope
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                CardView(Card(content: "X", id: "test1"))
            }
            HStack {
                CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and I hope it fits", id: "test1"))
                CardView(Card(isMatched: true, content: "X", id: "test1"))
            }
        }
            .padding()
            .foregroundColor(.green)
    }
    
}
