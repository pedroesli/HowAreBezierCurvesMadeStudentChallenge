//
//  InterpolationContainer.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/04/22.
//

import CoreGraphics

// A Equatable container to hold two values for any interpolation result
struct InterpolationContainer: Equatable {
    var qA: CGPoint = CGPoint.zero
    var qB: CGPoint = CGPoint.zero
}
