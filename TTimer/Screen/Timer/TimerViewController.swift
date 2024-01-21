//
//  ViewController.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import UIKit
import SnapKit
import SwiftUI

class TimerViewController: TTViewController {
    lazy private var scrambleLabel = TTUtils.makeLabel(text: "",
                                                       size: 14,
                                                       color: .black,
                                                       textAlignment: .center)
    lazy private var generateScrambleBtn = TTUtils.makeButton(title: "Next",
                                                              textColor: .blue,
                                                              textSize: 16)
    lazy private var scrambleView = ScrambleView()
    
    private let viewModel: TimerViewModel = .init()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    private func parseData() {
    }
    
    @objc private func didTapGenerateScramble() {
        scrambleLabel.text = viewModel.generateRandomScrambleList()
    }
}

extension TimerViewController {
    private func setupUI() {
        didTapGenerateScramble()
        generateScrambleBtn.addTarget(self, action: #selector(didTapGenerateScramble), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(scrambleLabel)
        view.addSubview(scrambleView)
        view.addSubview(generateScrambleBtn)
        
        scrambleView.cubeType = .two
        scrambleView.turnU()
    }
    
    private func layout() {
        scrambleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-TTUtils.bottomPadding(in: self))
        }
        
        scrambleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TTUtils.topPadding(in: self) + 16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        generateScrambleBtn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
