//
//  TimerManager.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 27/02/2024.
//

import Foundation

class TimerManager {
    static let shared = TimerManager()
    
    private var timer: Timer?
    
    private init() {
    }
    
    func startTimer(timeInterval: TimeInterval, target: Any, selector: Selector) {
        stopTimer()
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: target, selector: selector, userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

