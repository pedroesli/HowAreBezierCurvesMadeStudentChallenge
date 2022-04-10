//
//  TutorialInteractiveView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/04/22.
//

import SwiftUI

struct TutorialInteractiveView: View {
    
    @ObservedObject var manager: TutorialManager
    
    // Curve Points
    @State private var p1: CGPoint = CGPoint.zero
    @State private var p2: CGPoint = CGPoint.zero
    @State private var p3: CGPoint = CGPoint.zero
    @State private var p4: CGPoint = CGPoint.zero
    // Cubic interpolation point
    @State private var q0: CGPoint = CGPoint.zero
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let frame = geometry.frame(in: .local)
                ZStack{
                    DraggableStarPoint(position: $p1, text: "P1", frameLimit: frame) {
                        manager.movedStar()
                    }
                    DraggableStarPoint(position: $p2, text: "P2", frameLimit: frame) {
                        manager.movedStar()
                    }
                    DraggableStarPoint(position: $p3, text: "P3", frameLimit: frame) {
                        manager.movedStar()
                    }
                    DraggableStarPoint(position: $p4, text: "P4", frameLimit: frame) {
                        manager.movedStar()
                    }
                    // Asteroid
                    Image("Asteroid3")
                        .resizable()
                        .frame(width: 87, height: 70)
                        .position(q0)
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
                    
                    q0 = p1
                }
            }
            .onChange(of: manager.t, perform: { t in
                // Calculate the value of q0
                q0 = Bezier.cubicInterpolation(pointA: p1, pointB: p2, pointC: p3, pointD: p4, t: t)
            })
            .onAppear {
                manager.startTimer()
            }
        }
        .padding(EdgeInsets(top: 25, leading: 26, bottom: 25, trailing: 26))
    }
}

struct TutorialInteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialInteractiveView(manager: TutorialManager())
            .preferredColorScheme(.dark)
    }
}
