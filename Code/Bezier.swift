//
//  Bezier.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// Contains the necessary Bezier calculations that can be reused in a easy way
struct Bezier {
    
    // Formula used: (1-t)P0 + tP1
    static func linearInterpolation(pointA: CGPoint, pointB: CGPoint, t: CGFloat) -> CGPoint {
        return ((1 - t) * pointA) + (t * pointB)
    }
    
    // Formula used: (1-t)³P0 + 3(1-t)²tP1 + 3(1-t)t²P2 + t³P3
    // Broken into parts:
    // a = (1-t)³P0
    // b = 3(1-t)²tP1
    // c = 3(1-t)t²P2
    // d = t³P3
    // r = a + b + c + d
    static func cubicInterpolation(pointA: CGPoint, pointB: CGPoint, pointC: CGPoint, pointD: CGPoint, t: CGFloat) -> CGPoint {
        let a = pow(1-t, 3) * pointA
        let b = 3 * pow(1-t, 2) * t * pointB
        let c = 3 * (1-t) * t * t * pointC
        let d = t * t * t * pointD
        return a + b + c + d
    }
}
