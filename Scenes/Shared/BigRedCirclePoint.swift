//
//  BigRedCirclePoint.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

// The main and only one Big Boy Red Circle Point of the bezier curve
struct BigRedCirclePoint: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    @Binding var t: CGFloat
    
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(Color("BrightRedColor"))
            .position(Bezier.linearInterpolation(pointA: pointA, pointB: pointB, t: t))
    }
}

//struct BigRedCirclePoint_Previews: PreviewProvider {
//    static var previews: some View {
//        BigRedCirclePoint()
//    }
//}
