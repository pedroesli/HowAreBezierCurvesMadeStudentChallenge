//
//  NextButton.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/04/22.
//

import SwiftUI

// Modular next button to be reused 
struct NextButton: View {
    
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: 130, height: 80)
                        .foregroundColor(.blue)
                    Text("Next")
                        .font(Font.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .padding(.trailing, 10)
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(action: {
            
        })
    }
}
