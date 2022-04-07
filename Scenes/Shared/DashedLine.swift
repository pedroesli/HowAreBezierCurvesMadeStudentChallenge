//
//  DashedLine.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

struct DashedLine: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    
    var lineStyle = StrokeStyle(
        lineWidth: 12,
        lineCap: .round,
        lineJoin: .miter,
        miterLimit: 0,
        dash: [24, 24],
        dashPhase: 0
    )
    
    var body: some View {
        Path { path in
            path.move(to: pointA)
            path.addLine(to: pointB)
        }
        .stroke(Color("LightGrayColor"), style: lineStyle)
    }
}

struct DashedLine_Previews: PreviewProvider {
    static var previews: some View {
        DashedLine(
            pointA: .constant(CGPoint(x: 100, y: 300)),
            pointB: .constant(CGPoint(x: 300, y: 100))
        )
        .preferredColorScheme(.dark)
    }
}
