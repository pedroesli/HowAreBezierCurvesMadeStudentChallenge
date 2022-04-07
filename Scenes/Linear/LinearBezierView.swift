//
//  LinearBezierView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

struct LinearBezierView: View {
    
    @State private var p1: CGPoint = CGPoint.zero
    @State private var p2: CGPoint = CGPoint.zero
    @Binding var t: CGFloat // Interpolation 0 <= r <= 1
    @Binding var step: Step
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            ZStack{
                DashedLine(pointA: $p1, pointB: $p2)
                if step == .first || step == .second {
                    CirclePoint(pointA: $p1, pointB: $p2, t: $t)
                        .foregroundColor(.green)
                }
                else {
                    RedLine(pointA: $p1, pointB: $p2, t: $t)
                }
                DraggableStarPoint(position: $p1, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P1")
                DraggableStarPoint(position: $p2, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P2")
            }
            .onAppear {
                let mid = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                
                p1 = CGPoint(x: mid.x - 100, y: mid.y + 100)
                p2 = CGPoint(x: mid.x + 100, y: mid.y - 200)
            }
        }
    }
}

struct LinearBezierView_Previews: PreviewProvider {
    static var previews: some View {
        LinearBezierView(t: .constant(0.50), step: .constant(.second))
            .preferredColorScheme(.dark)
    }
}

fileprivate struct RedLine: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    @Binding var t: CGFloat
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: pointA)
                path.addLine(to: pointB)
            }
            .trim(from: 0, to: t)
            .stroke(Color("BrightRedColor"), lineWidth: 14)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Color("BrightRedColor"))
                .position(Bezier.linearInterpolation(pointA: pointA, pointB: pointB, t: t))
        }
    }
}
