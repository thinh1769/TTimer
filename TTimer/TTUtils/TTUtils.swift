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
    
    static func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection, spacing: CGFloat, isScrollEnabled: Bool) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = isScrollEnabled
        
        return collectionView
    }
    
    static func makeView(color: UIColor, cornerRadius: CGFloat?) -> UIView {
        let view = UIView()
        
        view.backgroundColor = color
        
        if let cornerRadius = cornerRadius {
            view.layer.cornerRadius = cornerRadius
        }
        
        return view
    }
    
    static func bottomPadding(in viewController: UIViewController) -> CGFloat {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaInsets.bottom
        } else {
            return 0
        }
    }

    static func topPadding(in viewController: UIViewController) -> CGFloat {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaInsets.top
        } else {
            return 0
        }
    }
}

