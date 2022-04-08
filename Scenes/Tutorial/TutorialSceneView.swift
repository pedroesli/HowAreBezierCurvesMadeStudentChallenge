//
//  SwiftUIView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/04/22.
//

import SwiftUI



struct TutorialSceneView: View {
    
    @StateObject private var manager = TutorialManager()
    
    var body: some View {
        VStack{
            Title("Tutorial")
            TutorialInteractiveView(manager: manager)
            TutorialBottomView(manager: manager)
        }
    }
}

struct TutorialSceneView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialSceneView()
            .preferredColorScheme(.dark)
    }
}
