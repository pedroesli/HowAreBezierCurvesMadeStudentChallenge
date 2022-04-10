//
//  QuadraticSceneView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// Complete Interactive Bezier Quadratic Scene
struct QuadraticSceneView: View {
    
    @State private var t: CGFloat = 0 // Interpolation 0 <= t <= 1
    @State private var step: Step = .first
    
    let markdownGuideText: [AttributedString] = [
        try! AttributedString(markdown: "How about making a **curve**? For that we can use a **Quadratic Bezier Curve**, that has three points."),
        try! AttributedString(markdown: "We use lerp between **P1** And **P2**, then **P2** to **P3**."),
        try! AttributedString(markdown: "We then use lerp again between those new points."),
        try! AttributedString(markdown: "Finaly we get a curve that goes from the first point to the last point. **P2** is the control point")
    ]
    
    var body: some View {
        VStack(spacing: 0){
            Title("Quadratic")
            QuadraticBezierView(t: $t, step: $step)
            BottomView(t: $t, step: $step, finalStep: .fourth, markdownGuideTexts: markdownGuideText)
        }
    }
}

struct QuadraticSceneView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticSceneView()
            .preferredColorScheme(.dark)
    }
}
