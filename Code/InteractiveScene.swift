//
//  Scene.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/03/22.
//

enum InteractiveScene: Int {
    case introduction
    case tutorial
    case linear
    case quadratic
    case cubic
    case final
    
    mutating func nextScene() {
        let nextStepValue = self.rawValue + 1
        guard let nextStep = InteractiveScene(rawValue: nextStepValue) else { return }
        self = nextStep
    }
}
