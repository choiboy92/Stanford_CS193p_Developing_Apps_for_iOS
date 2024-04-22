//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Junho Choi on 19/04/2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    /*
     create and initialize an instance of the observed object in the view's body or in a parent view,
     and then pass it to the view as a parameter.
     
     This allows the view to observe changes to the shared instance of the object
     */
    @StateObject var game =  EmojiMemoryGame()  // Create and initialize an instance of EmojiMemoryGame
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
