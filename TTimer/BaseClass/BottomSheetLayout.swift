//
//  BottomSheetLayout.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 23/03/2024.
//

import Foundation
import FloatingPanel

public final class BottomSheetLayout: FloatingPanelLayout {
    public let position: FloatingPanelPosition = .bottom
    public let initialState: FloatingPanelState = .half
    public let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring]
    
    public func backdropAlpha(for _: FloatingPanelState) -> CGFloat {
        return 0.3
    }
    
    init(ratio: CGFloat) {
        self.anchors = [
            .half: FloatingPanelLayoutAnchor(fractionalInset: ratio,
                                             edge: .bottom,
                                             referenceGuide: .superview)
        ]
    }
}
