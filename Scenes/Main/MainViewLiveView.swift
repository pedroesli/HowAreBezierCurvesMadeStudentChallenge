//
//  MainViewLiveView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/03/22.
//

import SwiftUI

public struct MainViewLiveView: View {
    
    public init() { }
    
    public var body: some View {
        ZStack{
            Color.black
            VStack{
                Image("SpaceshipAndLine")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 20)
                Spacer()
            }
            VStack(spacing: 40){
                Text("Lets learn how Bezier curves are made in a fun way and interactive way!")
                    .font(Font.system(size: 40, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                HStack{
                    Text("Press on the")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
                    Group{
                        Image(systemName: "play.fill")
                        Text("Play Button")
                    }
                    .font(Font.system(size: 24, weight: .bold, design: .rounded))
                    Text("to start an awesome experience!")
                        .font(Font.system(size: 24, weight: .regular, design: .rounded))
                }
            }
            .foregroundColor(.white)
            .padding(.top, 110)
            .padding(.horizontal, 20)
            VStack{
                Spacer()
                Image("BottomLine")
                    .resizable()
                    .scaledToFit()
            }
        }
        .ignoresSafeArea()
    }
}

struct MainViewLiveView_Previews: PreviewProvider {
    static var previews: some View {
        MainViewLiveView()
    }
}
