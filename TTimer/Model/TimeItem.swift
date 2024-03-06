//
//  TimeItem.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 03/03/2024.
//

import Foundation

struct TimeItem {
    var time: Int
    var scramble: [String]
    var createdDate: Int
    var penalty: Penalty
    
    init(time: Int, scramble: [String], createdDate: Int, penalty: Penalty = .none) {
        self.time = time
        self.scramble = scramble
        self.createdDate = createdDate
        self.penalty = penalty
    }
}
