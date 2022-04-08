//
//  DraggableStarPoint.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/03/22.
//

import SwiftUI

struct DraggableStarPoint: View {
    
    struct Limit {
        var max: CGFloat
        var min: CGFloat
        
        func isWithinLimit(of value: CGFloat) -> Bool{
            return value <= max && value >= min
        }
    }
    
    @Binding var position: CGPoint
    var hightLimit: Limit
    var text: String
    var stoppedDraggingAction: (() -> Void)?
    
    var body: some View {
        ZStack{
            Image("Star")
                .resizable()
                .frame(width: 51, height: 49)
                .foregroundColor(.blue)
            Text(text)
                .offset(x: 45, y: 0)
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .position(position)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if hightLimit.isWithinLimit(of: value.location.y) {
                        position = value.location
                    }
                    else if value.location.y > hightLimit.max {
                        // Move only in the top horizontal position
                        position = CGPoint(x: value.location.x, y: hightLimit.max)
                    }
                    else {
                        // Move only in the bottom horizontal position
                        position = CGPoint(x: value.location.x, y: hightLimit.min)
                    }
                })
                .onEnded({ _ in
                    stoppedDraggingAction?()
                })
        )
    }
}

struct DraggableStarPoint_Previews: PreviewProvider {
    static var previews: some View {
        let screenSize = UIScreen.main.bounds
        
        DraggableStarPoint(position: .constant(CGPoint(x: screenSize.width/2, y: screenSize.height/2)), hightLimit: DraggableStarPoint.Limit(max: 400, min: 100), text: "P1")
            .preferredColorScheme(.dark)
            
    }
}
