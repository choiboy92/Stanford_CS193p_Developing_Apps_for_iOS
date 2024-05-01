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
            cards
            
        }
        .padding()
    }
    
    
    var cards: some View {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color.white)
                .border(Color.black)
                .overlay(
                    viewModel.TestCard.overallContent()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(5)
                )
    }
}


#Preview {
    SetView(viewModel: SetViewModel())
}

