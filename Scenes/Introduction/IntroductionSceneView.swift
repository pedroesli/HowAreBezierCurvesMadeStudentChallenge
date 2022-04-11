//
//  IntroductionSceneView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/04/22.
//

import SwiftUI

struct IntroductionSceneView: View {
    
    @EnvironmentObject private var sceneManager: SceneManager
    let storyText = [
        "Ana is on a journey to get back home. But on her way, her systems couldn't detect in time a cluster of asteroids moving towards her. The spaceships autopilot did its best to calculate a new route to avoid them.",
        "But that wasn't enough since a small asteroid the size of a golf ball ended up hitting the spaceship and affected the autopilot.",
        "Now the only way for her to navigate is manually using Bezier Curvers. So before we can help her get back to Earth, we need to understand how Bezier Curvers are made and later make a safe route to avoid more asteroids. "
    ]
    @State var currentStoryIndex = 0
    
    var body: some View {
        ZStack {
            //Stars
            VStack{
                HStack {
                    Image("Star")
                        .rotationEffect(Angle.degrees(20))
                        .offset(x: 150, y: 20)
                    Spacer()
                    Image("Star")
                        .offset(x: -140, y: 0)
                }
                Spacer()
                HStack {
                    Image("Star")
                        .rotationEffect(Angle.degrees(10))
                        .offset(x: 25, y: 20)
                    Spacer()
                    Image("Star")
                        .rotationEffect(Angle.degrees(-50))
                        .offset(x: -40, y: 200)
                }
                Spacer()
            }
            .foregroundColor(.blue)
            
            
            //Text And Girl Image
            VStack{
                ZStack {
                    Image("GirlOnSpaceship")
                        .resizable()
                        .frame(width: 468, height: 381)
                    Image("Asteroid1")
                        .resizable()
                        .frame(width: 119.50, height: 122.30)
                        .offset(x: 300, y: -60)
                    Image("Asteroid2")
                        .resizable()
                        .frame(width: 67, height: 62.50)
                        .offset(x: 280, y: 200)
                    Image("Asteroid3")
                        .resizable()
                        .frame(width: 87, height: 70)
                        .offset(x: -280, y: -60)
                }
                .padding(.top, 50)
                Text(getCurrentStoryText())
                    .lineSpacing(4)
                    .foregroundColor(.white)
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.horizontal, 120)
                    .padding(.top, 90)
                Spacer()
                NextButton(action: pressedNextButton)
            }
        }
    }
    
    func getCurrentStoryText() -> String {
        return storyText[currentStoryIndex]
    }
    
    func pressedNextButton() {
        if currentStoryIndex == storyText.count - 1 {
            sceneManager.nextScene()
        }
        else {
            currentStoryIndex += 1
        }
    }
}

struct IntroductionSceneView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionSceneView()
            .preferredColorScheme(.dark)
    }
}
