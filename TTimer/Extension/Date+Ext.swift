//
//  Date+Ext.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 03/03/2024.
//

import Foundation

extension Date {
    func toInt() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
