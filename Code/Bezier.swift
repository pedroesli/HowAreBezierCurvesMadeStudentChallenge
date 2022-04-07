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
    static func linearInterpolation(pointA: CGPoint, pointB: CGPoint, t: CGFloat) -> CGPoint{
        return ((1 - t) * pointA) + (t * pointB)
    }
    
}
