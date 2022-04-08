//
//  FinalSceneView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/04/22.
//

import SwiftUI

struct FinalSceneView: View {
    
    @StateObject private var manager = FinalSceneManager()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let frame = geometry.frame(in: .local)
                //let earthPosition = CGPoint(x: geometry.size.width - 150, y: frame.minY + 100)
                let earthPosition = CGPoint(x: frame.maxX - 150, y: frame.minY + 100)
                let mid = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                let asteroid1Frame = CGRect(
                    x: mid.x - 200,
                    y: mid.y,
                    width: 119.50,
                    height: 122.3
                )
                let asteroid2Frame = CGRect(
                    x: mid.x + 100,
                    y: mid.y + 200,
                    width: 144.15,
                    height: 134.50
                )
                let asteroid3Frame = CGRect(
                    x: mid.x + 200,
                    y: mid.y - 120,
                    width: 113.35,
                    height: 91
                )
                ZStack{
                    // Assets
                    Image("Earth")
                        .resizable()
                        .frame(width: 380, height: 380)
                        .position(earthPosition)
                    Image("Asteroid1")
                        .resizable()
                        .frame(width: asteroid1Frame.width, height: asteroid1Frame.height)
                        .position(asteroid1Frame.origin)
                    Image("Asteroid2")
                        .resizable()
                        .frame(width: asteroid2Frame.width, height: asteroid2Frame.height)
                        .position(asteroid2Frame.origin)
                    Image("Asteroid3")
                        .resizable()
                        .frame(width: asteroid3Frame.width, height: asteroid3Frame.height)
                        .position(asteroid3Frame.origin)
                    // Cubic Bezier
                    CubicBezier(t: $manager.t, frame: frame) { interpolationResult in
                        manager.spaceshipPosition = Bezier.linearInterpolation(pointA: interpolationResult.qA, pointB: interpolationResult.qB, t: manager.t)
                    }
                    // Spaceship
                    Image("GirlRidingSpaceship")
                        .resizable()
                        .frame(width: 175.64, height: 134.65)
                        .position(manager.spaceshipPosition)
                    
                }
                .onAppear {
                    manager.registerAsteroid(frame: asteroid1Frame)
                    manager.registerAsteroid(frame: asteroid2Frame)
                    manager.registerAsteroid(frame: asteroid3Frame)
                    
                    manager.earthFrame = CGRect(x: earthPosition.x, y: earthPosition.y, width: 380 * 1.30, height: 380 * 1.30)
                    
                    manager.reduceAsteroidFrameSize()
                }
            }
            // Interpolation value text
            HStack{
                Spacer()
                Text(String(format: "t=%.2f", manager.t))
                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .overlay {
            CongratulationsView(isPresenting: $manager.didCollideWithEarth)
        }
    }
    
}

struct FinalSceneView_Previews: PreviewProvider {
    static var previews: some View {
        FinalSceneView()
            .preferredColorScheme(.dark)
    }
}

fileprivate struct CubicBezier: View {
    
    // Curve Points
    @State private var p1: CGPoint = CGPoint.zero
    @State private var p2: CGPoint = CGPoint.zero
    @State private var p3: CGPoint = CGPoint.zero
    @State private var p4: CGPoint = CGPoint.zero
    // Interpolation Points
    @State private var q1: CGPoint = CGPoint.zero
    @State private var q2: CGPoint = CGPoint.zero
    @State private var q3: CGPoint = CGPoint.zero
    @State private var q4: CGPoint = CGPoint.zero
    @State private var q5: CGPoint = CGPoint.zero
    @Binding var t: CGFloat
    
    var frame: CGRect
    var interpolationResultAction: ((InterpolationLine.InterpolationContainer) -> Void)?
    
    var body: some View {
        ZStack{
            DashedLine(pointA: $p1, pointB: $p2)
            DashedLine(pointA: $p2, pointB: $p3)
            DashedLine(pointA: $p3, pointB: $p4)
            
            // Green Lines
            Group {
                InterpolationLine(
                    pointA: $p1,
                    pointB: $p2,
                    pointC: $p3,
                    t: $t,
                    interpolationResultAction: { interpolationResult in
                        q1 = interpolationResult.qA
                        q2 = interpolationResult.qB
                    })
                InterpolationLine(
                    pointA: $p2,
                    pointB: $p3,
                    pointC: $p4,
                    t: $t,
                    interpolationResultAction: { interpolationResult in
                        // qA interpolation is not needed since its the same as q2 and we only need 3 points to make the final interpolation line
                        q3 = interpolationResult.qB
                    })
            }
            .foregroundColor(.green)
            // Cyan Lines
            InterpolationLine(pointA: $q1, pointB: $q2, pointC: $q3, t: $t, interpolationResultAction: { interpolationResult in
                interpolationResultAction?(interpolationResult)
            })
            .foregroundColor(.cyan)
            
            DraggableStarPoint(position: $p1, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.maxY - 200), text: "P1")
            DraggableStarPoint(position: $p2, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P2")
            DraggableStarPoint(position: $p3, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P3")
            DraggableStarPoint(position: $p4, hightLimit: DraggableStarPoint.Limit(max: frame.maxY, min: frame.minY), text: "P4")
        }
        .onAppear {
            p1 = CGPoint(x: frame.minX + 100, y: frame.maxY - 100)
            p2 = CGPoint(x: frame.midX - 100, y: frame.midY)
            p3 = CGPoint(x: frame.midX + 50, y: frame.midY + 400)
            p4 = CGPoint(x: frame.maxX - 100, y: frame.midY + 100)
        }
    }
    
}

fileprivate struct CongratulationsView: View {
    
    @Binding var isPresenting: Bool
    
    var body: some View {
        if isPresenting {
            VStack {
                Text("Congratulations! 👏 you helped Peter evade the asteroides and leanered how to use Bezier curves. I hope you enjoed this project and choose me as the winner. 😁")
                    .foregroundColor(.white)
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 40)
            }
            .frame(width: 550, height: 500)
            .background {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(Color("LightGrayColor"))
            }
        }
    }
}
