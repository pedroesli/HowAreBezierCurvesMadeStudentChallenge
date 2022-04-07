//
//  LinearSceneView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// Complete Interactive Bezier Linear Scene
struct LinearSceneView: View {
    
    @State private var t: CGFloat = 0 // Interpolation 0 <= t <= 1
    @State private var step: Step = .first
    
    let guideText = [
        "First step of drawing  a Bezier curve",
        "Second step of drawing  a Bezier curve"
    ]
    
    let markdownGuideText: [AttributedString] = [
        try! AttributedString(markdown: "We start with **two points** connected by a line segment. We can calculate the **third point** by using a formula called **Linear Interpolation** or lerp for short."),
        try! AttributedString(markdown: "Second step of drawing a Bezier curve"),
    ]
    
    var body: some View {
        VStack{
            Title("Linear")
            LinearBezierView(t: $t, step: $step)
            BottomView(t: $t, step: $step, finalStep: .second, markdownGuideTexts: markdownGuideText)
        }
    }
}

struct LinearSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LinearSceneView()
            .previewDevice("iPad Air (4th generation)")
            .preferredColorScheme(.dark)
    }
}
