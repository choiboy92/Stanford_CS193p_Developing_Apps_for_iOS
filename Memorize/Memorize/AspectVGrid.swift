//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Junho Choi on 29/04/2024.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View  {
    var items: [Item]   // set as don't care
    var aspectRatio: CGFloat = 1
    // var content: () -> View     // can't specify a function that returns a view as it is a protool
    var content: (Item) -> ItemView // a don't care that conforms to View
    // i.e. a custom function that is passed in that takes in an item and shows a view
    // in our case, it will take in viewModel.card -> CardView
    // @ViewBuilder var content: (Item) -> ItemView // can also assign ViewBuilder here
    
    // @ViewBuilder added - interprets function as an argument as a Viewbuilder func
    // viewBuilder-ise at argument level for initialisation
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
            
    func gridItemWidthThatFits(
       count: Int,
       size: CGSize,
       atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat { // CGFloat is the floats we use when drawing
        // strategy -- try every type of column count till the cards fit vertically
        var columnCount = 1.0 // turn into float so make it interoperable with CGFloat type
        let count = CGFloat(count) // make a function scoped var that is of different type to the argument
        // N.b. the function ver count IS NOT THE SAME AS the argument count passed in
        
        repeat {
            let width = size.width / columnCount   // find width of each column for a certain number of columns
            let height = width / aspectRatio       // find height required for that width
            
            // calculate number of rows required for a certain number of cards
            let rowCount = (count / columnCount).rounded(.up)
            
            // if total height required by the cards is more than the size of the container cards
            // then continue the loop by increasing the number of columns we are using
            // but if height required by cards is less than the container height, we will use that number of columns
            if rowCount * height < size.height {
                // round down just in case rounding up pushes our height over the limit (size.height)
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        // we want the card's width to be either:
        // 1. the width of the
        // 2. the height that the LazyVGrid was offered -> maximum width
        return min(size.width/count, size.height*aspectRatio).rounded(.down)
    }
}
