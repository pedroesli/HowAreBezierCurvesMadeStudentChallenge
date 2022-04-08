//
//  SimpleTimer.swift
//  
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/03/22.
//

import SwiftUI

///Just a Simple Timer with easy methods
class SimpleTimer {
    
    var timeInterval: TimeInterval
    private var timer: Timer!
    
    
    init(timeInterval: TimeInterval = 0.03 ) {
        self.timeInterval = timeInterval
    }
    
    /// Will execute the block after the specified timeInterval
    func start(block: @escaping ()->Void) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            block()
        })
    }
    
    func stop() {
        timer.invalidate()
    }
}
