//
//  CubicSceneView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/03/22.
//

import SwiftUI

struct CubicSceneView: View {
    
    @State private var t: CGFloat = 0 // Interpolation 0 <= t <= 1
    @State private var step: Step = .first
    
    let markdownGuideText: [AttributedString] = [
        try! AttributedString(markdown: "The most common curve is the Cubic Bezier Curve, that uses two control points. They are **P2** and **P3**."),
        try! AttributedString(markdown: "We repeat the same steps as before by applying lerp to each point."),
        try! AttributedString(markdown: "Then we lerp between the green points to get our final and middle point."),
        try! AttributedString(markdown: "And we are able to draw the curve. So it's basically **Linear Interpolation** all the way down to the last point.")
    ]
    
    var body: some View {
        VStack{
            Title("Cubic")
            CubicBezierView(t: $t, step: $step)
            BottomView(t: $t, step: $step, finalStep: .fourth, markdownGuideTexts: markdownGuideText)
        }
    }
}

struct CubicSceneView_Previews: PreviewProvider {
    static var previews: some View {
        CubicSceneView()
            .preferredColorScheme(.dark)
    }
}
