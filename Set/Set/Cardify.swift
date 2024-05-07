//
//  Cardify.swift
//  Memorize
//
//  Created by Junho Choi on 29/04/2024.
//
// Building out Cardify vierwModifier

import SwiftUI

struct Cardify: ViewModifier {
//    let isFaceUp: Bool
    
    // base function requirement for this to conform to the viewModifier protocol
    func body(content: Content) -> some View {
        // this is the view that is returned by the viewModifier
        ZStack() {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius) // use TYPE INFERENCE
            base.strokeBorder(lineWidth: Constants.lineWidth)   // makes more specific strokeBorder that control the size
                .background(base.fill(.white))  // set card background as white
                .overlay(content)               // overlayed by the emojii BUT not controlling size
//                .opacity(isFaceUp ? 1 : 0)
//            base.fill()
//                .opacity(isFaceUp ? 0 : 1)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify() -> some View {
        modifier(Cardify())
    }
}
