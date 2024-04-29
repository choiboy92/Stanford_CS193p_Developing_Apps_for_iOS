//
//  Pie.swift
//  Memorize
//
//  Created by Junho Choi on 29/04/2024.
//
// View Component - not a swiftUI file tho as it is a View because it is shape

import SwiftUI
import CoreGraphics     // -> CG

struct Pie: Shape {
    
    var startAngle: Angle = Angle.zero // n.b. zero is upper-left corner
    
    let endAngle: Angle
    var clockwise = true
    // on MacOS it is the same
    
    // given a rectangle, what path should this shape take
    // rectangle can be a container
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height)/2
        
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        // do what I need to do with Path here before returning - define the shape
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise    // iOS clockwise is different to how we percieve it (i.e. opposite)
        )
        p.addLine(to:center)
        
        
        
        
        return p
    }
}
