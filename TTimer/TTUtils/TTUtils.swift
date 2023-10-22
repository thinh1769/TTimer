//
//  TTUtils.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import Foundation
import UIKit

class TTUtils {
    static func makeLabel(text: String, size: CGFloat, color: UIColor, textAlignment: NSTextAlignment?) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.font.withSize(size)
        label.textColor = color
        
        if let textAlignment = textAlignment {
            label.textAlignment = textAlignment
        }
        
        return label
    }
}

