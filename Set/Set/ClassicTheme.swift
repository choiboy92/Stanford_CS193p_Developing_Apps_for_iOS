//
//  ClassicTheme.swift
//  Set
//
//  Created by Junho Choi on 16/05/2024.
//

import SwiftUI
import Foundation

struct ClassicTheme: Equatable {
    
    let featureNum = 4
    
    func featureList(f1 ShapeType: Trool,
                     f2 NumberOfShapes: Trool,
                     f3 ShapeShade: Trool,
                     f4 ShapeColor: Trool
    ) -> [Trool] {

        return [ShapeType, NumberOfShapes, ShapeShade, ShapeColor]
    }
    
    
    struct CardContent: View {
        let ShapeType: Trool
        let NumberOfShapes: Trool
        let ShapeShade: Trool
        let ShapeColor: Trool
        
        var num: Int = 0// = NumberOfShapesImplementation()
        var c: Color? = nil // = WhichColor()
        
        init(_ cardFeatures: [Trool]) {
            self.ShapeType = cardFeatures[0]
            self.NumberOfShapes = cardFeatures[1]
            self.ShapeShade = cardFeatures[2]
            self.ShapeColor = cardFeatures[3]
            
            self.num = NumberOfShapesImplementation()
            self.c = WhichColor()
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
        func ShapeImplementation(with color: Color) -> some View {
            switch ShapeType {
            case .state1:
                ShapeShadingImplementation(to: RoundedRectangle(cornerRadius: 50.0), with: color)     // Rounded rectangle
            case .state2:
                ShapeShadingImplementation(to: Capsule(), with: color)     // Rectangle
            case .state3:
                ShapeShadingImplementation(to: Diamond(), with: color)        // diamond
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
        
        
        var body: some View {
            VStack {
                Spacer()
                // Text("\(featureList)")
                ForEach(0..<num, id:\.self) { _ in
                    ShapeImplementation(with: c!)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.bottom, 5)
                        .padding(.top, 5)
                        .aspectRatio(2, contentMode: .fit)
                }
                Spacer()
            }
        }
    }
}
    

