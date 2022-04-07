//
//  InterpolationLine.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// A line with two circle points to represent the points that are being interpolated, with the option of hiding the line.
struct InterpolationLine: View {
    
    struct InterpolationContainer: Equatable {
        var qA: CGPoint = CGPoint.zero
        var qB: CGPoint = CGPoint.zero
    }
    
    @State private var interpolationContainer = InterpolationContainer()
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    @Binding var pointC: CGPoint
    @Binding var t: CGFloat
    var hideLine = false
    var interpolationResultAction: ((_ interpolationResult: InterpolationContainer) -> Void)?
    
    
    var body: some View {
        ZStack{
            CirclePoint(pointA: $pointA, pointB: $pointB, t: $t) { interpolationResult in
                interpolationContainer.qA = interpolationResult
            }
            CirclePoint(pointA: $pointB, pointB: $pointC, t: $t) { interpolationResult in
                interpolationContainer.qB = interpolationResult
            }
            if !hideLine {
                SimpleLine(pointA: $interpolationContainer.qA, pointB: $interpolationContainer.qB)
            }
        }
        .onChange(of: interpolationContainer) { newValue in
            interpolationResultAction?(newValue)
        }
    }
}

//struct InterpolationLine_Previews: PreviewProvider {
//    static var previews: some View {
//        InterpolationLine()
//    }
//}
