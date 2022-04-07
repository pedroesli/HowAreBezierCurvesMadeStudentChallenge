//
//  CirclePoint.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// A simple circle to represent a point in the Bezier animation (Doesnt have color, so you can apply after)
struct CirclePoint: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    @Binding var t: CGFloat
    var interpolationAction: ((_ interpolationResult: CGPoint) -> Void)?
    
    var body: some View {
        let interpolation = Bezier.linearInterpolation(pointA: pointA, pointB: pointB, t: t)
        Circle()
            .frame(width: 18, height: 18)
            .position(interpolation)
            .onChange(of: interpolation) { newValue in
                interpolationAction?(newValue)
            }
    }
}

//struct CirclePoint_Previews: PreviewProvider {
//    static var previews: some View {
//        CirclePoint()
//    }
//}
