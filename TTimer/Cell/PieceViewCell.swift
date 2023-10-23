//
//  PieceViewCell.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 23/10/2023.
//

import UIKit
import SnapKit

class PieceViewCell: UICollectionViewCell {
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func config(color: PieceColor) {
        switch color {
        case .white:
            backgroundColor = .white
        case .green:
            backgroundColor = .green
        case .yellow:
            backgroundColor = .yellow
        case .orange:
            backgroundColor = .orange
        case .red:
            backgroundColor = .red
        case .blue:
            backgroundColor = .blue
        }
    }
}

extension PieceViewCell {
    private func setupUI() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
    }
    
    private func layout() {
        
    }
}
