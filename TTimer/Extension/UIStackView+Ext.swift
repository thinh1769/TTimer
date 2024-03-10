//
//  UIStackView+Ext.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 10/03/2024.
//

import UIKit

public extension UIStackView {
    convenience init(views: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .vertical,
                     spacing: CGFloat = 0) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
    }
}
