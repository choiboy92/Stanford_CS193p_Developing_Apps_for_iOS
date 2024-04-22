//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Junho Choi on 22/04/2024.
//


// VIEW MODEL SPECIFIC TO EMOJI

import SwiftUI   // need to import UI as it needs to know



// closure as a global function
func createCardContent(forPairAtIndex index: Int) -> String {
    return ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"][index]
}


// Talks to View & Model -> needs variables for Model & View
class EmojiMemoryGame {
    
    
    // partial separation - there is nothing stopping the View from talking directly to model via viewModel.model:
    /*
    var model: MemoryGame<String>   // specified the generic as string (for emojis)
    */
    
    // PRIVATE - only code that can talk to/use this var is this class
    /*
    private var model: MemoryGame<String>   // full separation
    */
    
    // class - free initialiser only works when variables have default values so we need to set default value
    // CLOSURE VERSION OF FUNCTION CREATECARDCONTENT ABOVE:
    /*
    private var model: MemoryGame<String> = MemoryGame<String>(
        numberOfPairsOfCards: 4,
        cardContentFactory: { (index: Int) -> String in
            return ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"][index]
        }
    )
    */
    
    // USING TRAILING CLOSURE SYNTAX + TYPE INFERENCE:
    /*
    private var model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in      // pairIndex can be replaced with $0 = first argument
        return ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"][pairIndex]
    }
    */
    
    // STATIC VAR & FUNC - Make it global but namespace it inside my class + Private it
    private static let emojis = ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"]     // making it global (within the class) ensures its initialised first
    // Can also do for functions - need to make PRIVATE & STATIC so that MemoryGame is initialised before I set as the model variable
    private static func createMemoryGame() -> MemoryGame<String> {     // specify return type - N.B. RETURN TYPE CANNOT BE INFERRED
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in      // pairIndex can be replaced with $0 = first argument
            // ensure the index exists in the array
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
            return emojis[pairIndex]    // global private static var accessible in class scope
        }
    }
    private var model = createMemoryGame()  // call the private static (global) function that creates a memory game
    
    
    // Therefore, would need to make accessible to View only the things it needs
    // Almost a layer of access control
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // would also need to make any methods it requires to interact with the model, public
    // INTENT FUNCTION
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
    
    
}


