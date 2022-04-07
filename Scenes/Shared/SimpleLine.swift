//
//  SimpleLine.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

/// A simple smaller continuous line
struct SimpleLine: View {
    
    @Binding var pointA: CGPoint
    @Binding var pointB: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: pointA)
            path.addLine(to: pointB)
        }
        .stroke(lineWidth: 5)
    }
}

//struct SimpleLine_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleLine()
//    }
//}
