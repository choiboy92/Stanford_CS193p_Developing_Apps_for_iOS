//
//  ContentView.swift
//  Memorize
//
//  Created by Junho Choi on 19/04/2024.
//

import SwiftUI

// ContentView [behaves like] View - a protocol
// different to Int or String
//struct ContentView: View {
//    // computed property
//    var body: some View {
//        // some View = can run anything as long as it returns a type view
//        VStack() {      // VStack is a struct with default parameters
//      //VStack(content: { -- equivalently passes below as argument
//            Image(systemName: "globe")  // image struct + named parameter systemName
//                .imageScale(.large)     // view modifier - a function (method)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")       // text struct
//        }
//        .padding()  // view modifier - scopes to elements inside the view
//    }
//}
//
//#Preview {
//    ContentView()
//}


struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .padding()  // view modifier - scopes to elements inside the view
    }
}

// Build a custom view element
struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack() {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("👻")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

#Preview {
    ContentView()
}
