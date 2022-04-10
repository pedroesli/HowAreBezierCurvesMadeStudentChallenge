//
//  MainView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/03/22.
//

import SwiftUI

final class SceneManager: ObservableObject {
    @Published var scene: InteractiveScene = .introduction
    
    func nextScene(){
        scene.nextScene()
    }
}

public struct MainView: View {
    
    @StateObject var sceneManager = SceneManager()
    
    public init() { }
    
    public var body: some View {
        ZStack{
            if sceneManager.scene == .introduction {
                IntroductionSceneView()
            }
            else if sceneManager.scene == .tutorial {
                TutorialSceneView()
            }
            else if sceneManager.scene == .linear {
                LinearSceneView()
            }
            else if sceneManager.scene == .quadratic {
                QuadraticSceneView()
            }
            else if sceneManager.scene == .cubic {
                CubicSceneView()
            }
            else if sceneManager.scene == .final {
                FinalSceneView()
            }
        }
        .background(Color.black)
        .environmentObject(sceneManager)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
