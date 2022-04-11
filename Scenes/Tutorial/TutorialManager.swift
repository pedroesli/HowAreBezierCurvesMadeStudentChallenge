//
//  TutorialManager.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/04/22.
//

import SwiftUI

class TutorialManager: ObservableObject {
    
    @Published var t: CGFloat = 0 // Interpolation 0 <= t <= 1
    @Published var step: Step = .first
    @Published var textIndex = 0
    
    private var tTimer: SimpleTimer = SimpleTimer()
    private let guideTimeInterval: TimeInterval = 2
    private var didMoveStar = false
    private var didMoveSlider = false
    
    let markdownGuideTexts: [AttributedString] = [
        try! AttributedString(markdown: "Move any star to begin."),
        try! AttributedString(markdown: "Nice job! 👏"),
        try! AttributedString(markdown: "Now lets manualy control the animation."),
        try! AttributedString(markdown: "Well done! 🥳 Now you'll learn how **Bezier Curves** are made. Enjoy!")
    ]
    
    func stopTimer() {
        tTimer.stop()
    }
    
    func startTimer() {
        tTimer.start(block: tUpdate)
    }
    
    func getCurrentGuideText() -> AttributedString{
        return markdownGuideTexts[textIndex]
    }
    
    func nextStep() {
        step.nextStep()
    }
    
    func nextText() {
        textIndex += 1
    }
    
    func movedStar() {
        if didMoveStar { return }
        didMoveStar = true
        
        // Show the next text
        nextText()
        // Then after a certain time show the next tutorial step (Move slider step)
        Timer.scheduledTimer(withTimeInterval: guideTimeInterval, repeats: false) { [weak self] _ in
            self?.nextStep()
            self?.nextText()
        }
    }
    
    func movedSlider() {
        if didMoveSlider { return }
        didMoveSlider = true
        
        // Show the next text and the next button
        nextText()
        nextStep()
    }
    
    /// Updating t value
    private func tUpdate(){
        if t >= 1 {
            t = 0
        }
        t += 0.01
    }
    
}
