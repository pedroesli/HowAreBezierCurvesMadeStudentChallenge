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
        try! AttributedString(markdown: "First step of drawing a Bezier curve"),
        try! AttributedString(markdown: "Second step of drawing a Bezier curve"),
        try! AttributedString(markdown: "Third step of drawing a Bezier curve"),
        try! AttributedString(markdown: "Fourth step of drawing a Bezier curve")
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
