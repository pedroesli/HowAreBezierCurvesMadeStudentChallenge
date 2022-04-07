//
//  BottomView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// Bottom view of the interactive Bezier curve scenes
struct BottomView: View {
    
    @Binding var t: CGFloat
    @Binding var step: Step
    var finalStep: Step
    var markdownGuideTexts: [AttributedString]
    var simpleTimer: SimpleTimer = SimpleTimer()
    
    @EnvironmentObject private var sceneManager: SceneManager
    
    var body: some View {
        VStack(spacing: 45){
            // Info Text
            Text(markdownGuideTexts[step.rawValue])
                .foregroundColor(.white)
                .font(Font.system(size: 40, weight: .regular, design: .rounded))
                .minimumScaleFactor(0.5)
                .padding()
                .frame(width: 550, height: 150)
                .background {
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color("LightGrayColor"))
                }
            ZStack{
                NextButton {
                    if step == finalStep {
                        // Go to the next scene
                        sceneManager.nextScene()
                    }
                    else{
                        step.nextStep()
                    }
                }
                
                // Slider & Interpolation Text
                VStack{
                    HStack{
                        Slider(value: $t, in: 0...1, onEditingChanged: { editing in
                            //If is editing, stop automatic animation
                            if editing {
                                simpleTimer.stop()
                            }
                            else{
                                simpleTimer.start(block: tUpdate)
                            }
                        })
                        .tint(.blue)
                        .padding(.horizontal, 200)
                        .padding(.bottom, 10)
                    }
                    HStack{
                        Spacer()
                        Text(String(format: "t=%.2f", t))
                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            simpleTimer.start(block: tUpdate)
        }
    }
    
    /// Updating t value
    func tUpdate(){
        if t >= 1 {
            t = 0
        }
        t += 0.01
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView(
            t: .constant(0.5),
            step: .constant(.first),
            finalStep: .second,
            markdownGuideTexts: [
                try! AttributedString(markdown: "Hello, **World!**"),
                try! AttributedString(markdown: "My name is **Pedro**")
            ]
        )
    }
}

//["Hello, World!", "My name is Pedro"]
