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
        
        //func getRestrictedPosition(from value)
    }
    
    @Binding var position: CGPoint
    var text: String
    var stoppedDraggingAction: (() -> Void)?
    
    private var heightLimit: Limit
    private var widthLimit: Limit
    
    /**
        Initializer for a Draggable Star Point.
     
        - Parameters:
            - position: A binding position to indicate where the star is being positioned
            - text: A guide text to apear on the right side of the star
            - frameLimit: A frame to limit where the star can be moved
            - stoppedDraggingAction: A optional closure that is called when the star has stopped being dragged
     */
    init(position: Binding<CGPoint>, text: String, frameLimit: CGRect, stoppedDraggingAction: (() -> Void)? = nil){
        self._position = position
        self.text = text
        self.stoppedDraggingAction = stoppedDraggingAction
        
        heightLimit = Limit(max: frameLimit.maxY, min: frameLimit.minY)
        widthLimit = Limit(max: frameLimit.maxX, min: frameLimit.minX)
    }
    
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
                    if heightLimit.isWithinLimit(of: value.location.y) && widthLimit.isWithinLimit(of: value.location.x){
                        position = value.location
                    }
                    else if !heightLimit.isWithinLimit(of: value.location.y) {
                        if value.location.y > heightLimit.max {
                            // Move only in the bottom horizontal position
                            if value.location.x < widthLimit.max && value.location.x > widthLimit.min{
                                position = CGPoint(x: value.location.x, y: heightLimit.max)
                            }
                        }
                        else {
                            // Move only in the top horizontal position
                            if value.location.x < widthLimit.max && value.location.x > widthLimit.min{
                                position = CGPoint(x: value.location.x, y: heightLimit.min)
                            }
                        }
                    }
                    else if !widthLimit.isWithinLimit(of: value.location.x) {
                        if value.location.x > widthLimit.max {
                            // Movel only in the right vertical position
                            position = CGPoint(x: widthLimit.max, y: value.location.y)
                        }
                        else{
                            // Movel only in the left vertical position
                            position = CGPoint(x: widthLimit.min, y: value.location.y)
                        }
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
        
        DraggableStarPoint(
            position: .constant(CGPoint(x: screenSize.width/2, y: screenSize.height/2)),
            text: "P1",
            frameLimit: CGRect(x: 0, y: 0, width: 300, height: 300)
        )
        .preferredColorScheme(.dark)
            
    }
}
