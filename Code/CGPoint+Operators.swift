//
//  CGPoint+Operators.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(
            x: left.x + right.x,
            y: left.y + right.y
        )
    }
    
    static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        return CGPoint(
            x: left * right.x,
            y: left * right.y
        )
    }
}
