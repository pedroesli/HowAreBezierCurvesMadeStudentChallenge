//
//  QuadraticBezierView.swift
// 
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

struct QuadraticBezierView: View {
    
    // Curve Points
    @State private var p1: CGPoint = CGPoint.zero
    @State private var p2: CGPoint = CGPoint.zero
    @State private var p3: CGPoint = CGPoint.zero
    // Interpolation Points
    @State private var q1: CGPoint = CGPoint.zero
    @State private var q2: CGPoint = CGPoint.zero
    @Binding var t: CGFloat // Interpolation 0 <= t <= 1
    @Binding var step: Step
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            ZStack{
                DashedLine(pointA: $p1, pointB: $p2)
                DashedLine(pointA: $p2, pointB: $p3)
                if step == .first || step == .second{
                    // Show only the green points
                    InterpolationLine(pointA: $p1, pointB: $p2, pointC: $p3, t: $t, hideLine: true)
                        .foregroundColor(.green)
                }
                else if step == .third {
                    // Show the interpolation between those green points with the line
                    InterpolationLine(pointA: $p1, pointB: $p2, pointC: $p3, t: $t)
                        .foregroundColor(.green)
                }
                else {
                    // Show the final result with the red bezier curve
                    InterpolationLine(
                        pointA: $p1,
                        pointB: $p2,
                        pointC: $p3,
                        t: $t,
                        interpolationResultAction: { interpolationResult in
                            q1 = interpolationResult.qA
                            q2 = interpolationResult.qB
                    })
                    .foregroundColor(.green)
                    RedQuadraticBezierCurve(p1: $p1, p2: $p2, p3: $p3, t: $t)
                    BigRedCirclePoint(pointA: $q1, pointB: $q2, t: $t)
                }
                DraggableStarPoint(position: $p1, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P1")
                DraggableStarPoint(position: $p2, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P2")
                DraggableStarPoint(position: $p3, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P3")
            }
            .onAppear {
                let mid = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                
                p1 = CGPoint(x: mid.x - 150, y: mid.y + 100)
                p2 = CGPoint(x: mid.x + 100, y: mid.y - 200)
                p3 = CGPoint(x: mid.x + 150, y: mid.y + 250)
            }
        }
    }
}

struct QuadraticBezierView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticBezierView(t: .constant(0.5), step: .constant(.third))
            .preferredColorScheme(.dark)
    }
}

/// Draws the main red bezier curve
fileprivate struct RedQuadraticBezierCurve: View {
    
    @Binding var p1: CGPoint
    @Binding var p2: CGPoint
    @Binding var p3: CGPoint
    @Binding var t: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: p1)
            path.addQuadCurve(to: p3, control: p2)
        }
        .trim(from: 0, to: t)
        .stroke(Color("BrightRedColor"), lineWidth: 14)
    }
    
}

