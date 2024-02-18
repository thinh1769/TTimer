//
//  ViewController.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import UIKit
import SnapKit
import SwiftUI
import Combine

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
    
    var cancellableSet: Set<AnyCancellable> = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscription()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    private func parseData() {
    }
    
    @objc private func didTapGenerateScramble() {
        scrambleLabel.text = viewModel.generateScramble()
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
        
        viewModel.cubeType = .six
        scrambleView.cubeType = viewModel.cubeType
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
    
    private func setupSubscription() {
        cancellableSet = []
        
        viewModel.$scramble
            .receive(on: DispatchQueue.main)
            .sink { [weak self] scramble in
                guard let self else { return }
                self.scrambleView.scrambleList = scramble
            }
            .store(in: &cancellableSet)
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
