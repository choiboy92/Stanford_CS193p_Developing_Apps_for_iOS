//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Junho Choi on 22/04/2024.
//


// THIS IS OUR MODEL!

import Foundation


// DOntCare = CardContent, could be image, string, etc.
struct MemoryGame<CardContent> where CardContent: Equatable {
//    var cards: Array<Card>
    // dont want other classes/struct to change the cards - looking is allowed
    private(set) var cards: Array<Card>     // access control
    // Start vars as private and only let it be public when you need it
    
    
    // want to specify a custom init as the free default init would require the viewModel to provide the cards variable when called
    // We DONT want this - model should create the cards + private (set) prevents viewModel from setting
    // SO, we create a custom init that should initialise the cards=
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {     // cardContentFactory - FUNCTION AS A TYPE
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            // CardContent is a "don't care" for the model - viewModel knows the type (a string)
            // SO, we call the var cardContentFactory which is a function type
            // allows viewModel with knowledge about content type, to pass knowledge along as a function that creates the correct content
            // functional programming - hides implementation
            let content: CardContent = cardContentFactory(pairIndex)    // content is determined by a function
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    // Card is a value type (struct) - so we are passed a copy of it
    // BUT we want to change the isFaceUp property of the chosen Card actually in our model!
    mutating func choose(_ card: Card) {
        print("chose \(card)")
        // card.isFaceUp.toggle()      // Cannot use mutating member on immutable value: 'card' is a 'let' constant
        
        let chosenIndex = index(of: card)   // use a custom function to match the index of the chosen card to one in the array (in the model)
        cards[chosenIndex].isFaceUp.toggle()    // toggle the actual chosen Card in the model (not a copy of it)
    }
    
    /// function to find index of chosen card
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0    // FIXME: bogus!
    }
    
    // create a mutating func to shuffle - specifies it to copy on write when this is called
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // sublevel struct - MemoryGame.Card
    // no <CardContent> here - would need to specify each time Card is used
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        /*
        // conform to equatable for animation
        // define the rules for the protocol that makes cards equatable
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content      // Referencing operator function '==' on 'Equatable' requires that 'CardContent' conform to 'Equatable'
            /*
             need to make CardContent[idontcare] (but we dont know what it is) conform to Equatable
             Specify that above in line #15 -- "where CardContent: Equatable"
             i.e. we don't know what it is BUT it should conform equatabl - idontcare -> care a bit
             
             now that cardcontent is equatable - can delete this custom bit as Swift automatically knows bools are equatable
             */
        }
        */
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent    // card content wont change during the game
        
        var id: String    // ObjectIdentifier used to conform to identifiable protocol - it is essentially an idontcare, we replace with string
        
        // used to confrom to CustomDebugStringConvertible
        // allows us to customise how the card is printed in the console for debug purposes
        // i.e. like logging
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched":"")"
        }
    }
}
