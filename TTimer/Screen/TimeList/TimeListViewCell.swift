//
//  TimeListViewCell.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import UIKit
import SnapKit

class TimeListViewCell: UICollectionViewCell {
    private lazy var timeLabel = TTUtils.makeLabel(text: "",
                                               size: 12,
                                               color: .black)
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(time: String) {
        timeLabel.text = time
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        addSubview(timeLabel)
    }
    
    private func layout() {
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalToSuperview().inset(8)
        }
    }
}
