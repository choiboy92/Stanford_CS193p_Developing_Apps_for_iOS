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
 //      //VStack(content: { -- equivalently passes below as argument - TupleView
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
     // needs to be a var as we want it to change
     // var isFaceUp: Bool = false     // stored property needs a value when called
     @State var isFaceUp = false    // STATE - creates a pointer to this variable for temporary state
     // will get rid of @State when implementing game logic in backend

     var body: some View {
         /*
         // PASSED A CLOSURE (A FUNCTION AS AN ARGUMENT)
         ZStack(alignment: .top, content: {
             RoundedRectangle(cornerRadius: 12)
         }
         // THEREFORE CAN REWRITE USING TRAILING CLOSURE SYNTAX:
         ZStack(alignment: .top) {
             RoundedRectangle(cornerRadius: 12)
         }
         // IF USING DEFAULT ARGUMENTS, CAN REMOVE PARENTHESES:
         ZStack {
             RoundedRectangle(cornerRadius: 12)
         }
         */
         ZStack() {
             // can create a constant from types
             let base = RoundedRectangle(cornerRadius: 12) // use TYPE INFERENCE
             // equivalent to - let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
             
             if isFaceUp {
                 base.foregroundColor(.white)
                 base.strokeBorder(lineWidth: 2)
                 Text("👻")
                     .font(.largeTitle)
             } else {
                 base
             }
         }
         // add a view modifier for when card is tapped - TRAILING CLOSURE SYNTAX
         .onTapGesture {
             // print("tapped") // print to console
             isFaceUp.toggle()   // used @State for variable to enable it to be changed (temporarily)
         }
     }
 }

#Preview {
    ContentView()
}
