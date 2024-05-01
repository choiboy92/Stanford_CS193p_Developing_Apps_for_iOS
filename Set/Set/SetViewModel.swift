//
//  SetViewModel.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//
// VIEWMODEL SPECIFIC TO THIS IMPLEMENTATION OF SET

import SwiftUI





class SetViewModel: ObservableObject {
    
    private static let ShapeType: Trool = .state2
    private static let NumberOfShapes: Trool = .state3
    private static let ShapeFilling: Trool = .state3
    private static let ShapeColor: Trool = .state2
        
    
    var TestCard = ClassicTheme(feature1: ShapeType, feature2: NumberOfShapes, feature3: ShapeFilling, feature4: ShapeColor)
    
    
    
    
    struct ClassicTheme: Equatable {
        private let ShapeType: Trool
        private let NumberOfShapes: Trool
        private let ShapeFilling: Trool
        private let ShapeColor: Trool
     
        private let featureList: [Trool]
        
        init(feature1: Trool, feature2: Trool, feature3: Trool, feature4: Trool) {
            self.ShapeType = feature1
            self.NumberOfShapes = feature2
            self.ShapeFilling = feature3
            self.ShapeColor = feature4
            
            self.featureList = [ShapeType, NumberOfShapes, ShapeFilling, ShapeColor]
            
        }
        
        @ViewBuilder
        func overallContent() -> some View {
            let num: Int = NumberOfShapesImplementation()
            let sh = ShapeImplementation()
            
            VStack {
                Text("\(num)")
                ForEach(0..<num) { _ in
                    sh
                        .padding(10.0)
                }
            }
            
            
        }
        
        @ViewBuilder
        func ShapeImplementation() -> some View {
            switch ShapeType {
            case .state1:
                ShapeColorImplementation(to: RoundedRectangle(cornerRadius: 5.0))     // Rounded rectangle
            case .state2:
                ShapeColorImplementation(to: Rectangle())     // Rectangle
            case .state3:
                ShapeColorImplementation(to: Circle())        // diamond
            }
        }
        
        func NumberOfShapesImplementation() -> Int {
            switch NumberOfShapes {
            case .state1:
                return 1
            case .state2:
                return 2
            case .state3:
                return 3
            }
        }
        
        @ViewBuilder
        func ShapeColorImplementation(to shape: some Shape) -> some View {
            switch ShapeFilling {
            case .state1:
                shape.fill(Color.green)
            case .state2:
                shape.fill(Color.blue)
            case .state3:
                shape.fill(Color.red)
            }
        }
    }
}


