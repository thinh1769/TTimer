//
//  TimeDetailViewModel.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 24/03/2024.
//

import Foundation

class TimeDetailViewModel {
    var context: Context
    
    public init(context: Context) {
        self.context = context
    }
}

extension TimeDetailViewModel {
    struct Context {
        var time: TimeItem
        
        init(time: TimeItem) {
            self.time = time
        }
    }
}
