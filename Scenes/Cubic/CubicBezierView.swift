//
//  CubicBezierView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/03/22.
//

import SwiftUI

struct CubicBezierView: View {
    
    // Curve Points
    @State private var p1: CGPoint = CGPoint.zero
    @State private var p2: CGPoint = CGPoint.zero
    @State private var p3: CGPoint = CGPoint.zero
    @State private var p4: CGPoint = CGPoint.zero
    // Interpolation Points
    @State private var q1: CGPoint = CGPoint.zero
    @State private var q2: CGPoint = CGPoint.zero
    @State private var q3: CGPoint = CGPoint.zero
    @State private var q4: CGPoint = CGPoint.zero
    @State private var q5: CGPoint = CGPoint.zero
    @Binding var t: CGFloat // Interpolation 0 <= t <= 1
    @Binding var step: Step
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            ZStack{
                DashedLine(pointA: $p1, pointB: $p2)
                DashedLine(pointA: $p2, pointB: $p3)
                DashedLine(pointA: $p3, pointB: $p4)
                
                if step == .first {
                    // Show only the green points
                    InterpolationLine(pointA: $p1, pointB: $p2, pointC: $p3, t: $t, hideLine: true)
                        .foregroundColor(.green)
                    InterpolationLine(pointA: $p2, pointB: $p3, pointC: $p4, t: $t, hideLine: true)
                        .foregroundColor(.green)
                }
                else if step == .second{
                    // Show the interpolation between those green points with the line
                    InterpolationLine(pointA: $p1, pointB: $p2, pointC: $p3, t: $t)
                        .foregroundColor(.green)
                    InterpolationLine(pointA: $p2, pointB: $p3, pointC: $p4, t: $t)
                        .foregroundColor(.green)
                }
                else if step == .third {
                    // Show the interpolation between the green lines with a cyan line
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
                    InterpolationLine(
                        pointA: $p2,
                        pointB: $p3,
                        pointC: $p4,
                        t: $t,
                        interpolationResultAction: { interpolationResult in
                            // qA interpolation is not needed since its the same as q2 and we only need 3 points to make the final interpolation line
                            q3 = interpolationResult.qB
                        })
                        .foregroundColor(.green)
                    InterpolationLine(pointA: $q1, pointB: $q2, pointC: $q3, t: $t)
                        .foregroundColor(.cyan)
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
                    InterpolationLine(
                        pointA: $p2,
                        pointB: $p3,
                        pointC: $p4,
                        t: $t,
                        interpolationResultAction: { interpolationResult in
                            // qA interpolation is not needed since its the same as q2 and we only need 3 points to make the final interpolation line (qB is the interpolation of p3 and p4)
                            q3 = interpolationResult.qB
                        })
                        .foregroundColor(.green)
                    InterpolationLine(
                        pointA: $q1,
                        pointB: $q2,
                        pointC: $q3,
                        t: $t,
                        interpolationResultAction: { interpolationResult in
                            // We need q4 and q5
                            q4 = interpolationResult.qA
                            q5 = interpolationResult.qB
                        })
                        .foregroundColor(.cyan)
                    RedCubicBezierCurve(p1: $p1, p2: $p2, p3: $p3, p4: $p4, t: $t)
                    BigRedCirclePoint(pointA: $q4, pointB: $q5, t: $t)
                }
                
                
                DraggableStarPoint(position: $p1, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P1")
                DraggableStarPoint(position: $p2, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P2")
                DraggableStarPoint(position: $p3, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P3")
                DraggableStarPoint(position: $p4, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P4")
            }
            .onAppear {
                let mid = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                
                p1 = CGPoint(x: mid.x - 250, y: mid.y + 100)
                p2 = CGPoint(x: mid.x, y: mid.y - 200)
                p3 = CGPoint(x: mid.x + 50, y: mid.y + 250)
                p4 = CGPoint(x: mid.x + 250, y: mid.y)
            }
        }
    }
}

struct CubicBezierView_Previews: PreviewProvider {
    static var previews: some View {
        CubicBezierView(t: .constant(0.50), step: .constant(.fourth))
            .preferredColorScheme(.dark)
    }
}

fileprivate struct RedCubicBezierCurve: View {
    
    @Binding var p1: CGPoint
    @Binding var p2: CGPoint
    @Binding var p3: CGPoint
    @Binding var p4: CGPoint
    @Binding var t: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: p1)
            path.addCurve(to: p4, control1: p2, control2: p3)
        }
        .trim(from: 0, to: t)
        .stroke(Color("BrightRedColor"), lineWidth: 14)
    }
}
