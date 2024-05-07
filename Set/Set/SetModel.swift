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
    
    
//    init(numberOfFeatures: Int, cardContentFactory: [Trool]) {
//        cards = []
//        for i in 0..<max(0, numberOfFeatures) {
//            let content: CardContent = cardContentFactory(i)
//            let feature = cardContentFactory[i]
//            for c in feature.allCases {
//                
//            }
//            cards.append(Card(id: "\(i)", featureList: <#T##[Trool]#>, content: <#T##Equatable#>))
//        }
//    }
    
    // var TestCard: Card
    // want to create an array of cards that contain all combinations of the features
    // iterate through the features,
    
    init(cardContentFactory: () -> [Trool]) {
        cards = []
        let content = cardContentFactory()
        cards.append(Card(id: "test_card", featureState: content))
    }
    
    struct Card: Equatable, Identifiable {
        
        var id: String
        var featureState: [Trool]    // holds the state of each of the card features
        
        var isSelected: Bool = false
        var isPartOfSet: Bool = false
//        let content: themeContent    // card content wont change during the game
    }
    
    
}
