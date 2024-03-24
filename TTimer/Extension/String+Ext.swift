//
//  String+Ext.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 24/03/2024.
//

import Foundation

extension String {
    func getScramble(_ scr: [String]) -> String {
        var result = ""
        
        for scrCharacter in scr {
            result.append(scrCharacter + " ")
        }
        
        return result
    }
}
