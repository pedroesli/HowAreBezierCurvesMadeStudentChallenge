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
    
    let markdownGuideTexts: [AttributedString] = [
        try! AttributedString(markdown: "We start with **two points** connected by a line segment. We can calculate the **third point** by using a formula called **Linear Interpolation** or lerp for short."),
        try! AttributedString(markdown: "The lerp formula used is **(1-t)P0 + tP1**. Where **t** is like a percentage that determines where to position the third point."),
        try! AttributedString(markdown: "Lets see it in action! We can use it to draw a line between **P1** and **P2**.")
    ]
    
    var body: some View {
        VStack(spacing: 0){
            Title("Linear")
            LinearBezierView(t: $t, step: $step)
            BottomView(t: $t, step: $step, finalStep: .third, markdownGuideTexts: markdownGuideTexts)
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
