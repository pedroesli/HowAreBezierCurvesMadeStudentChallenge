//
//  Step.swift
// 
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

enum Step: Int {
    case first
    case second
    case third
    case fourth
    
    mutating func nextStep() {
        let nextStepValue = self.rawValue + 1
        guard let nextStep = Step(rawValue: nextStepValue) else { return }
        self = nextStep
    }
}
