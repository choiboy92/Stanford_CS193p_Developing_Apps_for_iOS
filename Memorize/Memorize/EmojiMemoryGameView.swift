//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Junho Choi on 19/04/2024.
//

import SwiftUI


// ContentView [behaves like] View - a protocol
 // different to Int or String
 //struct EmojiMemoryGameView: View {
 //    // computed property
 //    var body: some View {
 //        // some View = can run anything as long as it returns a type view
 //        VStack() {      // VStack is a struct with default parameters
 //      //VStack(content: { -- equivalently passes below as argument - TupleView
 //            Image(systemName: "globe")  // image struct + named parameter systemName
 //                .imageScale(.large)     // view modifier - a function (method)
 //                .foregroundStyle(.tint)
 //            Text("Hello, world!")       // text struct
 //        }
 //        .padding()  // view modifier - scopes to elements inside the view
 //    }
 //}
 //
 //#Preview {
 //    EmojiMemoryGameView()
 //}


 struct EmojiMemoryGameView: View {
     // initialise the ViewModel - view reacts to changes in viewModel
     var viewModel: EmojiMemoryGame  = EmojiMemoryGame()
     // TODO: Correctly set viewModel, above is not the way to do it - will learn later
     
//     let emojiThemes: [String: [String]] = ["halloween": ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"],
//                                            "christmas": ["🎄", "🎅", "🎁", "🎉", "🏡", "🌟"],
//                                            "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🏸"]]
//     @State var emojis: [String] = []
     @State var cardCount: Int = 6
     
     var body: some View {
         VStack{
             Text("Memorize!")
                 .font(.largeTitle)
                 .fontWeight(.bold)
             Spacer()
             ScrollView {
                 cards
             }
             Button("Shuffle") {
                 viewModel.shuffle()    // user intent - shuffle
             }
             
              Spacer()
             // cardCountAdjusters
             // themeSelector

         }
         .padding()  // view modifier - scopes to elements inside the view
     }
     
     // separate out elements to their own "some View"
     var cards: some View {
         
         LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
             // iterable view constructor
             ForEach(0..<viewModel.cards.count, id: \.self) { index in
                 CardView(viewModel.cards[index])   // use custom init in cardview to specify no external name
                     .aspectRatio(2/3, contentMode: .fit)
                     .padding(4)
             }
         }
         .foregroundColor(.orange)
     }
     
     var cardCountAdjusters: some View {
         HStack {
             cardRemover
             Spacer()
             cardAdder
         }
     }
     
     var cardRemover: some View {
//         Button("remove Card") {
//             cardCount -= 1
//         }
         
//         // another type of button constructor:
//         Button(action: {
//             if cardCount > 1{
//                 cardCount -= 1
//             }
//         }, label: {
//             Image(systemName: "rectangle.stack.badge.minus.fill")
//         })
//         .imageScale(.large)
//         .font(.largeTitle)
         
         // using our custom constructor function:
         cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
     }
     
     var cardAdder: some View {
//         Button("add Card") {
//             cardCount += 1
//         }
         
//         // Another type of button constructor:
//         Button(action: {
//             if cardCount < emojis.count {
//                 cardCount += 1
//             }
//         }, label: {
//             Image(systemName: "rectangle.stack.badge.plus.fill")
//         })
//         .imageScale(.large)
//         .font(.largeTitle)
         
         // use the custom constructor function
         cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
     }
     
     // As cardAdder & cardRemover are similar elements - can dynamically construct as a function:
     func cardCountAdjuster(by offset: Int, symbol: String) -> some View {      // n.b. returns a view
         // by = external parameter name
         // offset = internal parameter name
         Button(action: {
             cardCount += offset
         }, label: {
             Image(systemName: symbol)
         })
         .imageScale(.large)
         .font(.largeTitle)
         .disabled(cardCount+offset < 1 || cardCount+offset > viewModel.cards.count)
         // separate view modifier for protections
     }
     /*
     func selectCardSet(theme: String, logo: String) -> some View {
         Button(action: {
             emojis = emojiThemes[theme]! + emojiThemes[theme]!
             emojis = emojis.shuffled()
         }, label: {
             VStack {
                 Image(systemName: logo)
                 Text(theme)
             }
         })
         .imageScale(.large)
         .font(.headline)
     }
     
     var themeHalloween: some View {
         selectCardSet(theme: "halloween", logo: "fireworks")
     }
     
     var themeChristmas: some View {
         selectCardSet(theme: "christmas", logo: "snowflake")
     }
     
     var themeSports: some View {
         selectCardSet(theme: "sports", logo: "figure.handball")
     }
     
     var themeSelector: some View {
         HStack {
             themeHalloween
             Spacer()
             themeChristmas
             Spacer()
             themeSports
         }
     }
     */
 }

 // Build a custom view element
 struct CardView: View {
     // Structs have default property initialisers
     
//     let content: String
     
     let card: MemoryGame<String>.Card
     
     // needs to be a var as we want it to change
     // var isFaceUp: Bool = false     // stored property needs a value when called
     // @State var isFaceUp = false    // STATE - creates a pointer to this variable for temporary state
     // will get rid of @State when implementing game logic in backend
     
     init(_ card: MemoryGame<String>.Card) {
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
             }
             .opacity(card.isFaceUp ? 1 : 0)
             base.fill().opacity(card.isFaceUp ? 0 : 1)
         }
     }
 }

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}
