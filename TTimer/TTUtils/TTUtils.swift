//
//  TTUtils.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import Foundation
import UIKit

class TTUtils {
    static func makeLabel(text: String,
                          size: CGFloat,
                          color: UIColor,
                          numberOfLine: Int = 0,
                          textAlignment: NSTextAlignment = .left,
                          isBold: Bool = false
    ) -> UILabel {
        let label = UILabel()
        
        label.text = text
        if !isBold {
            label.font = UIFont.systemFont(ofSize: size)
        } else {
            label.font = UIFont.boldSystemFont(ofSize: size)
        }
        label.textColor = color
        label.numberOfLines = numberOfLine
        label.textAlignment = textAlignment
        
        return label
    }
    
    static func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection,
                                   spacing: CGFloat,
                                   isScrollEnabled: Bool
    ) -> UICollectionView {
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
    
    static func makeView(color: UIColor,
                         cornerRadius: CGFloat = 0,
                         borderColor: CGColor = UIColor.clear.cgColor,
                         borderWidth: CGFloat = 0,
                         clipToBounds: Bool = false,
                         maskToBounds: Bool = false
    ) -> UIView {
        let view = UIView()
        
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = borderColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = maskToBounds
        view.clipsToBounds = clipToBounds
        
        return view
    }
    
    static func makeButton(title: String = "",
                           textColor: UIColor = .black,
                           textSize: CGFloat = 0,
                           backgroundColor: UIColor = .clear,
                           cornerRadius: CGFloat = 0,
                           borderColor: CGColor = UIColor.clear.cgColor,
                           borderWidth: CGFloat = 0,
                           rightIcon: UIImage? = nil
    ) -> UIButton {
        let button = UIButton()

        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font.withSize(textSize)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor
        
        if let image = rightIcon {
            button.setImage(image, for: .normal)
        }
        
        return button
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
    
    static func convertTime(_ seconds: Int, isShowMillisecond: Bool? = true) -> String {
        if seconds == 0 {
            return "0.00"
        }
        var secondsInterval = seconds / NumberDecimalPlaces.two.rawValue
        let millisecondsInterval = seconds - secondsInterval * NumberDecimalPlaces.two.rawValue
        if seconds > (60 * NumberDecimalPlaces.two.rawValue) {
            let minutesInterval = secondsInterval / 60
            secondsInterval = secondsInterval - minutesInterval * 60
            guard let isShowMillisecond else { return "" }
            if isShowMillisecond {
                return "\(minutesInterval):\(secondsInterval.toString()).\(millisecondsInterval.toString())"
            } else {
                return "\(minutesInterval):\(secondsInterval.toString())"
            }
        } else {
            guard let isShowMillisecond else { return "" }
            if isShowMillisecond {
                return "\(secondsInterval).\(millisecondsInterval.toString())"
            } else {
                return "\(secondsInterval)"
            }
        }
    }
    
    static func calculateTime(_ timeList: [TimeItem], averageType: AverageType) -> Int {
        let calArray = timeList.suffix(averageType.rawValue)
        var sum = calArray.reduce(0) { $0 + $1.time }
        if averageType != .mo3 {
            let min = calArray.min { $0.time < $1.time }
            let max = calArray.max { $0.time < $1.time }
            if let min, let max {
                sum = sum - min.time - max.time
            }
            return sum / (averageType.rawValue - 2)
        } else {
            return sum / averageType.rawValue
        }
    }
    
    static func getCubeTypeString(_ cubeType: CubeType) -> String {
        switch cubeType {
        case .two:
            return "2x2"
        case .three:
            return "3x3"
        case .four:
            return "4x4"
        case .five:
            return "5x5"
        case .six:
            return "6x6"
        case .seven:
            return "7x7"
        }
    }
}

