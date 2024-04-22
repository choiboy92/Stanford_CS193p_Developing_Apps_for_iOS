//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Junho Choi on 22/04/2024.
//


// THIS IS OUR MODEL!

import Foundation


// DOntCare = CardContent, could be image, string, etc.
struct MemoryGame<CardContent> {
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
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    
    func choose(_ card: Card) {
        
    }
    
    // create a mutating func to shuffle - specifies it to copy on write when this is called
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // sublevel struct - MemoryGame.Card
    // no <CardContent> here - would need to specify each time Card is used
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent    // card content wont change during the game
    }
}
