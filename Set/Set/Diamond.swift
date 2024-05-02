//
//  Diamond.swift
//  Set
//
//  Created by Junho Choi on 02/05/2024.
//

import SwiftUI
import CoreGraphics

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let midX = rect.midX
        let midY = rect.midY
        let x1: CGFloat = 0
        let x2 = midX + rect.width/2
        
        let y1: CGFloat = 0
        let y2 = midY + rect.height/2
        
        let start = CGPoint(x: midX, y: y1)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: x2, y: midY))
        p.addLine(to: CGPoint(x: midX, y: y2))
        p.addLine(to: CGPoint(x: x1, y: midY))
        p.addLine(to: start)
        p.closeSubpath()
        
        return p
    }
}

