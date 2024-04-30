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
        cards.shuffle()
    }
    
    
    // Optional as when game starts, no face up cards so null - computed property GET SET
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // when computed property is called
        get {
            /*
             var faceUpCardIndices = [Int]()     // empty array
             // iterate through all the cards and see if any are face up, if so append to the faceUpCadIndices array
             for index in cards.indices {
                 if cards[index].isFaceUp {
                     faceUpCardIndices.append(index)
                 }
             }
             // if after going through all, there is one card face up, return that index
             if faceUpCardIndices.count == 1 {
                 return faceUpCardIndices.first
             } else {
                 return nil  // if more or less than 1 card is face up, return None
             }
             */
            // above can be simplified via more functional programming
            
            /*
             var faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp } // FUNCTION AS ARGUMENT
             return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil     // return either index of faceup card OR nil if none
             
             above is removable once we add the "only" extension to Array
             */
            return cards.indices.filter { index in cards[index].isFaceUp }.only // FUNCTION AS ARGUMENT
            
        }
        // when a value is SET for indexOfTheOneAndOnlyFaceUpCard - newValue = value we set (automatically created constant)
        set {
            /*
             // turn the card that is set, face up, and any others face down
             for index in cards.indices {
                 if index == newValue {
                     cards[index].isFaceUp = true
                 } else {
                     cards[index].isFaceUp = false
                 }
             }
             */
            // iterate over indices of cards array and for each index ($0 is current index being iterated over),
            // checks if that index = newValue -> if yes the condition returns a true, setting that as the card's faceup condition
            return cards.indices.forEach {
                let wasFaceUp = cards[$0].isFaceUp  // store old value if faceUp was true
                cards[$0].isFaceUp = (newValue == $0)
                if wasFaceUp && !cards[$0].isFaceUp {   // check if wasFaceUp true AND currently face is down (i.e. flipped down)
                    cards[$0].seen = true       // set seen for that individual ID'd card as true
                }
            }  // trailing closure
            
        }
    }
    
    
    // Card is a value type (struct) - so we are passed a copy of it
    // BUT we want to change the isFaceUp property of the chosen Card actually in our model!
    mutating func choose(_ card: Card) {
        print("chose \(card)")
        // card.isFaceUp.toggle()      // Cannot use mutating member on immutable value: 'card' is a 'let' constant
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) { //index(of: card) {  // use a custom function to match the index of the chosen card to one in the array (in the model)
            // GAME LOGIC
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {      // if card is not matched and face down
                // safely unwrap the potential match index
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    // indexOfTheOneAndOnlyFaceUpCard = nil    // either matched already or no pair
                    // can get rid of above with the new compputed property of indexOfTheOneAndOnlyFaceUpCard
                    // we know
                    else {  // IF NO MATCH AFTER 2 cards have been turned face up
                        cards[chosenIndex].seen ? score-=1 : nil
                        cards[potentialMatchIndex].seen ? score-=1 : nil
                        
                    }
                } else {    // if no card is turned up (i.e. indexOfTheOneAndOnlyFaceUpCard optional is nil)
                    /*
                     // turn all the other cards face down & turn the chosenIndex card face up
                     // Move this into the computed property indexOfTheOneAndOnlyFaceUpCard
                     // difficult to keep track of setting changing variables in the method
                     
                    for index in cards.indices {
                        cards[index].isFaceUp = false
                    }
                     */
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex    // this is the first card that is turned up
                    // activates the set condition of the computed property
                }
                cards[chosenIndex].isFaceUp = true    // toggle the actual chosen Card in the model (not a copy of it)
            }
        }   // use if let to check the unwrap of the index optional
    }
    
    /// function to find index of chosen card
    func index(of card: Card) -> Int? {     // return type as Int optional - might not match
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    // create a mutating func to shuffle - specifies it to copy on write when this is called
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    private(set) var score: Int = 0
    
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
        var seen = false
        let content: CardContent    // card content wont change during the game
        
        var id: String    // ObjectIdentifier used to conform to identifiable protocol - it is essentially an idontcare, we replace with string
        
        // used to confrom to CustomDebugStringConvertible
        // allows us to customise how the card is printed in the console for debug purposes
        // i.e. like logging
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched":""), \(seen ? "seen":"not yet seen")"
        }
    }
}

/*
 create a custom extension to array for the computed property "only"
 
 it retrieves the only value in the array, or nil if it doesn't have one value
 (either more than one or no value)
 */
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
