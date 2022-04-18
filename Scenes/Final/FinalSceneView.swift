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
            .padding(EdgeInsets(top: 25, leading: 26, bottom: 25, trailing: 26))
            // Interpolation value text
            HStack{
                Spacer()
                Text(String(format: "t=%.2f", manager.t))
                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .disabled(manager.isSceneDisabled)
        .overlay {
            ZStack{
                BeginView(manager: manager)
                CongratulationsView(isPresenting: $manager.didCollideWithEarth)
            }
        }
    }
    
}

struct FinalSceneView_Previews: PreviewProvider {
    static var previews: some View {
        FinalSceneView()
            .preferredColorScheme(.dark)
    }
}

// A cubic bezier curve without the red curve meant for just the final scene
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
    var interpolationResultAction: ((InterpolationContainer) -> Void)?
    
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
            
            //TODO: Create a new frame that it limits y position to 200
            DraggableStarPoint(position: $p1, text: "P1", frameLimit: frame)
            DraggableStarPoint(position: $p2, text: "P2", frameLimit: frame)
            DraggableStarPoint(position: $p3, text: "P3", frameLimit: frame)
            DraggableStarPoint(position: $p4, text: "P4", frameLimit: frame)
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
    
    @EnvironmentObject private var sceneManager: SceneManager
    
    var body: some View {
        if isPresenting {
            VStack {
                Text("Congratulations! 👏 You helped Ana evade the asteroids and learned how Bezier Curves are made. I hope you enjoyed this interactive scene 😁. If you wish to replay all of the scenes again, just press the replay button.")
                    .foregroundColor(.white)
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 40)
                Button {
                    sceneManager.scene = .introduction
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .frame(width: 206, height: 80)
                            .foregroundColor(.blue)
                        Text("\(Image(systemName: "arrow.counterclockwise")) Replay")
                            .font(Font.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(width: 550, height: 605)
            .background {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(Color("LightGrayColor"))
            }
        }
    }
}

fileprivate struct BeginView: View {
    
    @ObservedObject var manager: FinalSceneManager
    @State private var isPresenting: Bool = true
    
    var body: some View {
        if isPresenting {
            VStack(spacing: 40){
                Text("Lets help Ana on her jorney back home by making a safe path for her. Good luck!")
                    .foregroundColor(.white)
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 40)
                Button {
                    isPresenting = false
                    manager.startScene()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .frame(width: 206, height: 80)
                            .foregroundColor(.blue)
                        Text("\(Image(systemName: "play.fill")) Begin")
                            .font(Font.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(width: 550, height: 400)
            .background {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(Color("LightGrayColor"))
            }
        }
    }
}
