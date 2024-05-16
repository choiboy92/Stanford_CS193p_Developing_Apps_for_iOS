//
//  SetModel.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//
// MODEL

import Foundation


struct SetModel {    
    private(set) var cards: Array<Card>     // access control
    private(set) var shownCards: Array<Card>     // access control
    
    init() {
        // want to create an array of cards that contain all combinations of the features
        // iterate through the features,
        
        cards = []
        var id = 0
        for f0 in Trool.allCases {
            for f1 in Trool.allCases {
                for f2 in Trool.allCases {
                    for f3 in Trool.allCases {
                        cards.append(Card(id: "\(id)", featureState: [f0, f1, f2, f3]))
                        id += 1
                    }
                }
            }
        }
        cards.shuffle()
        shownCards = Array(cards[..<12])
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        var featureState: [Trool]    // holds the state of each of the card features
        
        var isSelected: Bool = false
        var isPartOfSet: Bool = false
    }
}
