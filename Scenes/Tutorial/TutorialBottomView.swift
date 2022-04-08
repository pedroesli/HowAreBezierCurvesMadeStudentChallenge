//
//  SwiftUIView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/04/22.
//

import SwiftUI

struct TutorialBottomView: View {
    
    @ObservedObject var manager: TutorialManager
    
    @EnvironmentObject private var sceneManager: SceneManager
    
    var body: some View {
        VStack(spacing: 45) {
            InfoText(manager.getCurrentGuideText())
            ZStack{
                // Show Next Button only on the third step
                if manager.step == .third {
                    NextButton {
                        // Go to the next scene
                        sceneManager.nextScene()
                    }
                }
                
                // Show Slider only on the second step until the last step
                if manager.step == .second || manager.step == .third{
                    // Slider
                    VStack{
                        HStack{
                            Slider(value: $manager.t, in: 0...1, onEditingChanged: { editing in
                                //If is editing, stop automatic animation
                                if editing {
                                    manager.movedSlider()
                                    manager.stopTimer()
                                }
                                else{
                                    manager.startTimer()
                                }
                            })
                            .tint(.blue)
                            .padding(.horizontal, 200)
                            .padding(.bottom, 10)
                        }
                    }
                }
            }
        }
    }
}

//struct TutorialBottomView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialBottomView(t: <#Binding<CGFloat>#>, step: <#Binding<Step>#>, textIndex: <#Binding<Int>#>, markdownGuideTexts: <#[AttributedString]#>)
//    }
//}
