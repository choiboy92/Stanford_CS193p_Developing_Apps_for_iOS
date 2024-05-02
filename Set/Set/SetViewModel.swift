//
//  SetViewModel.swift
//  Set
//
//  Created by Junho Choi on 30/04/2024.
//
// VIEWMODEL SPECIFIC TO THIS IMPLEMENTATION OF SET

import SwiftUI





class SetViewModel: ObservableObject {
    
    private static let ShapeType: Trool = .state1
    private static let NumberOfShapes: Trool = .state3
    private static let ShapeShade: Trool = .state2
    private static let ShapeColor: Trool = .state1
        
    
    var TestCard = ClassicTheme(feature1: ShapeType, feature2: NumberOfShapes, feature3: ShapeShade, feature4: ShapeColor)
    
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

            self.featureList = [feature1, feature2, feature3, feature4]

        }
        
        @ViewBuilder
        func overallContent() -> some View {
            let num: Int = NumberOfShapesImplementation()
            let c = WhichColor()
            let sh = ShapeImplementation(with: c)
            
            VStack {
                Text("\(featureList)")
                ForEach(0..<num) { _ in
                    sh
                        .padding(10.0)
                }
            }
        }
        
        @ViewBuilder
        func ShapeImplementation(with color: Color) -> some View {
            switch ShapeType {
            case .state1:
                ShapeShadingImplementation(to: RoundedRectangle(cornerRadius: 50.0), with: color)     // Rounded rectangle
            case .state2:
                ShapeShadingImplementation(to: Rectangle(), with: color)     // Rectangle
            case .state3:
                ShapeShadingImplementation(to: Circle(), with: color)        // diamond
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
        
        func WhichColor() -> Color {
            switch ShapeColor {
            case .state1:
                .green
            case .state2:
                .blue
            case .state3:
                .red
            }
        }
        
        @ViewBuilder
        func ShapeShadingImplementation(to shape: some Shape, with color: Color) -> some View {
            switch ShapeShade {
            case .state1:
                shape
                    .stroke(color, lineWidth: 10.0)
                    .fill(Color.white)
            case .state2:
                shape
                    .stroke(color, lineWidth: 10.0)
                    .fill(color)
                    .opacity(0.5)
            case .state3:
                shape
                    .fill(color)
            }
        }
    }
}


