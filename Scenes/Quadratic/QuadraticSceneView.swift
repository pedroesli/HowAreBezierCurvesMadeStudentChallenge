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
        try! AttributedString(markdown: "First step of drawing a Bezier curve"),
        try! AttributedString(markdown: "Second step of drawing a Bezier curve"),
        try! AttributedString(markdown: "Third step of drawing a Bezier curve"),
    ]
    
    var body: some View {
        VStack{
            Title("Quadratic")
            QuadraticBezierView(t: $t, step: $step)
            BottomView(t: $t, step: $step, finalStep: .third, markdownGuideTexts: markdownGuideText)
        }
    }
}

struct QuadraticSceneView_Previews: PreviewProvider {
    static var previews: some View {
        QuadraticSceneView()
            .preferredColorScheme(.dark)
    }
}
