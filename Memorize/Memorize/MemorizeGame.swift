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
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    // sublevel struct - MemoryGame.Card
    // no <CardContent> here - would need to specify each time Card is used
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
