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
    private static let NumberOfShapes: Trool = .state2
    private static let ShapeShade: Trool = .state1
    private static let ShapeColor: Trool = .state1
        
    
//    var TestCard = ClassicTheme(feature1: ShapeType, feature2: NumberOfShapes, feature3: ShapeShade, feature4: ShapeColor)
    static var theme = ClassicTheme()
    
    private static func TestCardGeneration() -> SetModel {
        return SetModel {
            var flist: [Trool] = []
            for i in 0..<theme.featureNum {
                flist.append(Trool.state3)
            }
            return flist
        }
    }
    
    @Published private var model = TestCardGeneration()
    
    var cards: some View {    //Array<SetModel.Card> {
        AspectVGrid(model.cards, aspectRatio: 2/3) { card in
            SetViewModel.ClassicTheme.CardContent(card.featureState)
        }
        
    }
    
    
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
            // let sh = ShapeImplementation(with: c)
            
            init(_ cardFeatures: [Trool]) {
                self.ShapeType = cardFeatures[0]
                self.NumberOfShapes = cardFeatures[1]
                self.ShapeShade = cardFeatures[2]
                self.ShapeColor = cardFeatures[3]
                self.num = NumberOfShapesImplementation()
                
                self.c = WhichColor(ShapeColor)
                
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
            
            func WhichColor(_ c: Trool) -> Color {
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
                    ForEach(0..<num) { _ in
                        ShapeImplementation(with: c!)
                            .aspectRatio(2, contentMode: .fit)
                            .padding(10.0)
                    }
                    Spacer()
                }
            }
        }
        
        
        
        
        
        
    }
}


