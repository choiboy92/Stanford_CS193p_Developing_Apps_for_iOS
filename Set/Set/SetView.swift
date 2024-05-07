//
//  SetView.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//

import SwiftUI

struct SetView: View {
    //initialise the ViewModel - Reactive UI
    @ObservedObject var viewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("Set")
                .font(.title)
            Spacer()
            // AspectVGrid(<#T##items: [Identifiable]##[Identifiable]#>, aspectRatio: <#T##CGFloat#>, content: <#T##(Identifiable) -> View#>)
            CardView
            Spacer()
            
        }
        .padding()
    }
    
    
//    struct CardView: View {
//        typealias Card = SetModel<SetViewModel.ClassicTheme>
//        
//        let card: Card
//        
//        init(_ card: Card) {
//            self.card = card
//        }
//        
//        private struct Constants {
//            static let cornerRadius: CGFloat = 12
//            static let lineWidth: CGFloat = 2
//            static let inset: CGFloat = 5
//            struct FontSize {
//                static let largest: CGFloat = 200
//                static let smallest: CGFloat = 10
//                static let scaleFactor = smallest / largest
//            }
//            struct Pie {
//                static let opacity: CGFloat = 0.5
//                static let inset: CGFloat = 5
//            }
//        }
//        
//        var body: some View {
//            Card.overallContent()
//                .cardify()
//                .aspectRatio(1, contentMode: .fit)
//                .padding(5)
//        }
//        
//    }
    
    
    var CardView: some View {
        viewModel.cards
            .cardify()
            .aspectRatio(2/3, contentMode: .fit)
            .padding(5)
    }
}


#Preview {
    SetView(viewModel: SetViewModel())
}

