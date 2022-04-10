//
//  SwiftUIView.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/04/22.
//

import SwiftUI

struct InfoText: View {
    
    var text: AttributedString
    
    init(_ text: AttributedString){
        self.text = text
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .frame(height: 180)
            .foregroundColor(Color("LightGrayColor"))
            .padding(.horizontal, 60)
            .overlay {
                Text(text)
                    .foregroundColor(.white)
                    .font(Font.system(size: 40, weight: .regular, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 60)
                    .padding()
            }
    }
}

struct InfoText_Previews: PreviewProvider {
    static var previews: some View {
        InfoText(try! AttributedString(markdown: "Hello **World!**"))
    }
}
