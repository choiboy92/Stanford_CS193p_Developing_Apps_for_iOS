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
     //initialise the ViewModel - view reacts to changes in viewModel
     @ObservedObject var viewModel: EmojiMemoryGame
     /*
        REACTIVE UI - if this says something changed, redraw me!
        dont set "=" to anything - the view should watch for changes to an object that exists independently of the view
        if value is set, it implies that the view should observe changes to a specific instance of an object
        lifetime of it is determined by the lifetime of the object passed into it i.e. @StateObject
      */
     
     /*
     let emojiThemes: [String: [String]] = ["halloween": ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"],
                                            "christmas": ["🎄", "🎅", "🎁", "🎉", "🏡", "🌟"],
                                            "sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🏸"]]
     @State var emojis: [String] = []
     */
     
     @State var cardCount: Int = 6
     private let aspectRatio: CGFloat = 2/3
     
     var body: some View {
         VStack{
             Text("Memorize!")
                 .font(.largeTitle)
                 .fontWeight(.bold)
             Spacer()
             Text("\(viewModel.currentTheme.name)")
                 .font(.title3)
             Spacer()
//             ScrollView {
             cards
                 .animation(.default, value: viewModel.cards)   // value - only animate if that value changes
                 /*
                  Referencing instance method 'animation(_:value:)' on 'Array' requires that 'MemoryGame<String>.Card' conform to 'Equatable'
                  Animation works by trying to see if one version of the value is different to a new version by equating them
                  Needs to conform to Equatable - protocol
                  */
//             }
             HStack {
                 Button("New Game") {
                     // viewModel.shuffle()    // user intent - shuffle
                     viewModel.new_game()
                 }
                 Spacer()
                 Text("Score: \(viewModel.score)")
                     .font(.title3)
                 Spacer()
                 Button("Shuffle") {
                     viewModel.shuffle()    // user intent - shuffle
                 }
             }
              Spacer()
             // cardCountAdjusters
             // themeSelector
         }
         .padding()  // view modifier - scopes to elements inside the view
     }
     
     /*
     // separate out elements to their own "some View"
     @ViewBuilder   // var cards is a regular function - we turn it into a ViewBuilder
     // n.b. var body - view protocol is implicit with var body
     var cards: some View {
         /*
          spacing is platform dependent - then add padding after the fact for the individual cards
          
          can use .background as a way to see the area that the view takes up
          
          use geometry reader to remove scroll view and have cards adjust size so that all are shown
          To do so, we need to calculate what width the cards should be - create a function for this
          this uses the enum characteristic of geometry --> geometry.size
          */
        
         
         GeometryReader { geometry in
             let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
             )
             
             LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                 // iterable view constructor
                 /*
                  ForEach(0..<viewModel.cards.count, id: \.self) { index in
                  CardView(viewModel.cards[index])   // use custom init in cardview to specify no external name
                  .aspectRatio(2/3, contentMode: .fit)
                  .padding(4)
                  }
                  
                  forEach over indices of the array - it creates a view of the array
                  if array is shuffled, from forEach perspective, it still is showing the original array list
                  only now, because of the change, it overlays with a new view
                  
                  NEEDS to be edited to create a view based on the cards themselves rather than the array
                  
                  forEach now uses the cards, but needs the cards to conform to Identifiable (i.e. how do we know the 1st Pumpkin is moved rather than 2nd Pumpkin)
                  FIX: go back to MemoryGame and make cards conform to Identifiable by adding an additional id variable
                  */
                 
                 ForEach(viewModel.cards) { card in
                     CardView(card)   // use custom init in cardview to specify no external name
                         .aspectRatio(aspectRatio, contentMode: .fit)
                         .padding(4)
                         .onTapGesture {
                             viewModel.choose(card)
                         }
                 }
             }
         }
         .foregroundColor(viewModel.themeColor)
         // .background(.red)
         
     }
     
     func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
     ) -> CGFloat { // CGFloat is the floats we use when drawing
         // strategy -- try every type of column count till the cards fit vertically
         var columnCount = 1.0 // turn into float so make it interoperable with CGFloat type
         let count = CGFloat(count) // make a function scoped var that is of different type to the argument
         // N.b. the function ver count IS NOT THE SAME AS the argument count passed in
         
         repeat {
             let width = size.width / columnCount   // find width of each column for a certain number of columns
             let height = width / aspectRatio       // find height required for that width
             
             // calculate number of rows required for a certain number of cards
             let rowCount = (count / columnCount).rounded(.up)
             
             // if total height required by the cards is more than the size of the container cards
             // then continue the loop by increasing the number of columns we are using
             // but if height required by cards is less than the container height, we will use that number of columns
             if rowCount * height < size.height {
                 // round down just in case rounding up pushes our height over the limit (size.height)
                 return (size.width / columnCount).rounded(.down)
             }
             columnCount += 1
             
         } while columnCount < count
         // we want the card's width to be either:
         // 1. the width of the
         // 2. the height that the LazyVGrid was offered -> maximum width
         return min(size.width/count, size.height*aspectRatio).rounded(.down)
     }
     */
     
     /*
      NEW VAR CARD USING ASPECTVGRID (OUR CUSTOM VIEW )
      
      n.b. don't need @ViewBuilder - it returns a single view and acts as a normal function
      BUT we want AspectVGrid to be able to act like @ViewBuilder
      e.g. we may if-else in our content function
      */
     private var cards: some View {
         AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
             CardView(card)
                 // .aspectRatio(aspectRatio, contentMode: .fit)    // enforced in AspectVgrid
                 .padding(4)
                 .onTapGesture {
                     viewModel.choose(card)
                 }
         }
         .foregroundColor(viewModel.themeColor)
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

 
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
