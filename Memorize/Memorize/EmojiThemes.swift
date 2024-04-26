//
//  theme.swift
//  Memorize
//
//  Created by Junho Choi on 25/04/2024.
//
// THIS IS OUR MODEL FOR THE THEME

import Foundation


struct EmojiThemes {
    private static func initialiseThemes() -> Array<Theme> {
        return [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "👹", "😈", "💀", "🧙", "🙀", "😱", "☠️", "🍭"], numberOfPairs: 6, colorName: "green"),
                Theme(name: "Christmas", emojis: ["🎄", "🎅", "🎁", "🎉", "🏡", "🌟"], numberOfPairs: 6, colorName: "red"),
                Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🏸"], numberOfPairs: 4, colorName: "blue"),
                Theme(name: "Jobs", emojis: ["👮‍♀️", "💂‍♀️", "👷‍♀️", "👨‍🍳", "🧑‍🏫"], numberOfPairs: 4, colorName: "yellow"),
                Theme(name: "Food", emojis: ["🍎", "🍞", "🌮", "🍣", "🍫", "🍔", "🍕"], numberOfPairs: 4, colorName: "orange"),
                Theme(name: "Vehicles", emojis: ["🚗", "🚌", "🚒", "🚑", "🏎️", "🚓", "🚚"], numberOfPairs: 5, colorName: "indigo")]
    }
    
    private(set) var themes: Array<Theme> = initialiseThemes()  // access control
    var currentTheme: Theme? { return themes.randomElement() }
    
//    init() {
//        themes = EmojiThemes.initialiseThemes()
//        currentTheme = themes.randomElement()
//    }
    
    
    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairs: Int
        let colorName: String
    }
}
