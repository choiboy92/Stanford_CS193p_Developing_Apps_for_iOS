//
//  SetViewModel.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//
// VIEWMODEL SPECIFIC TO THIS IMPLEMENTATION OF SET

import SwiftUI

class SetViewModel: ObservableObject {
    var theme = ClassicTheme()
    
    private static func CardGeneration() -> SetModel {
        return SetModel()
    }
    
    @Published private var model = CardGeneration()
    
    var cards: Array<SetModel.Card> {
        return model.shownCards
    }
    
}


