//
//  FinalSceneManager.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/04/22.
//

import SwiftUI

// Detects all the necesary collions between the spaceship, asteroids and earth.
final class FinalSceneManager: ObservableObject {
    
    //MARK: Published properties
    @Published var spaceshipPosition: CGPoint = CGPoint.zero {
        didSet{
            checkCollisions()
        }
    }
    @Published var didCollideWithAsteroid = false {
        didSet {
            // Reset t if hit with asteroid
            resetT()
        }
    }
    @Published var didCollideWithEarth = false {
        didSet {
            sceneFinished()
        }
    }
    @Published var t: CGFloat = 0
    
    //MARK: Properties
    var spaceshipFrame: CGRect {
        return CGRect(
            x: self.spaceshipPosition.x,
            y: self.spaceshipPosition.y,
            width: 175.64 * 0.70,
            height: 134.65 * 0.70
        )
    }
    var asteroidFrames: [CGRect] = []
    var earthFrame: CGRect = CGRect.zero
    var simpleTimer = SimpleTimer(timeInterval: 0.05)
    
    //MARK: Initializers
    init(){
        simpleTimer.start(block: tUpdate)
    }
    
    //MARK: Methods
    func registerAsteroid(frame: CGRect) {
        asteroidFrames.append(frame)
    }
    
    func checkCollisions() {
        // Reset asteroid collision value
        if didCollideWithAsteroid {
            didCollideWithAsteroid = false
        }
        // Asteroids collision check
        for asteroidFrame in asteroidFrames {
            if spaceshipFrame.intersects(asteroidFrame) {
                didCollideWithAsteroid = true
                return
            }
        }
        // Earth collision check
        if spaceshipFrame.intersects(earthFrame) {
            didCollideWithEarth = true
        }
    }
    
    /// Updating t value
    func tUpdate(){
        if t >= 1 {
            t = 0
        }
        t += 0.01
    }
    
    func resetT(){
        if didCollideWithAsteroid {
            t = 0
        }
    }
    
    func sceneFinished(){
        if didCollideWithEarth {
            simpleTimer.stop()
        }
    }
    
    func reduceAsteroidFrameSize(){
        let reduceAmount = 0.50
        for (index, frame) in asteroidFrames.enumerated() {
            asteroidFrames[index] = CGRect(
                x: frame.origin.x,
                y: frame.origin.y,
                width: frame.width * reduceAmount,
                height: frame.height * reduceAmount
            )
        }
    }
}
