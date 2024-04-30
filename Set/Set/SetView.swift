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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    SetView(viewModel: SetViewModel())
}
