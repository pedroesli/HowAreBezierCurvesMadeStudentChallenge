//
//  Title.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

struct Title: View {
    
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack{
            Spacer()
            Text(title)
                .font(Font.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.top, 5)
            Spacer()
        }
    }
    
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title("Hello, World!")
            .preferredColorScheme(.dark)
    }
}
