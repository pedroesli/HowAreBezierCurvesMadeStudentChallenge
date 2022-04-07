//
//  GreenCircle.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// A simple circle to represent a point in the Bezier curve animation
struct PointCircle: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    @Binding var t: CGFloat
    var color: Color = .green
    
    var body: some View {
        Circle()
            .frame(width: 18, height: 18)
            .foregroundColor(color)
            .position(Bezier.linearInterpolation(pointA: pointA, pointB: pointB, t: t))
    }
    
}
