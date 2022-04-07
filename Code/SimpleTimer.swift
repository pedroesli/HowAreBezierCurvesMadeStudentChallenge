//
//  SimpleTimer.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

///Just a Simple Timer with easy methods
class SimpleTimer {
    
    private var timer: Timer!
    private let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval = 0.03 ) {
        self.timeInterval = timeInterval
    }
    
    func start(block: @escaping ()->Void) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            block()
        })
    }
    
    func stop() {
        timer.invalidate()
    }
}
