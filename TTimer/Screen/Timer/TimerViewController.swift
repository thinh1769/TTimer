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
                                                       size: 20,
                                                       color: .black,
                                                       textAlignment: .center)
    lazy private var timeLabel = TTUtils.makeLabel(text: "0.00",
                                                   size: 80,
                                                   color: .black,
                                                   textAlignment: .center)
    lazy private var resultLabel = TTUtils.makeLabel(text: "0.00",
                                                   size: 30,
                                                   color: .black,
                                                   textAlignment: .center)
    lazy private var timerLongPress = makeTimerLongPressGesture()
    lazy private var timerTapGesture = makeTimerTapGesture()
    lazy private var scrambleView = ScrambleView()
    private let viewModel: TimerViewModel = .init()
    private var cancellableSet: Set<AnyCancellable> = []
    private var timer: Timer?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscription()
        scrambleLabel.text = viewModel.generateScramble()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    private func parseData() {
    }
    
    @objc private func didStartTimer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            viewModel.previousTime = viewModel.currentTime
            viewModel.currentTime = 0
            timer = Timer.scheduledTimer(timeInterval: viewModel.timeInterval, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            timerTapGesture.isEnabled = true
            timerLongPress.isEnabled = false
        }
    }
    
    @objc func timerAction() {
        viewModel.currentTime += 1
        timeLabel.text = TTUtils.convertTime(viewModel.currentTime)
    }
    
    @objc private func didTapStopTimer(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            timer?.invalidate()
            timer = nil
            timeLabel.text = TTUtils.convertTime(viewModel.currentTime)
            resultLabel.text = TTUtils.convertTime(viewModel.previousTime)
            timerTapGesture.isEnabled = false
            timerLongPress.isEnabled = true
            scrambleLabel.text = viewModel.generateScramble()
            
        }
    }
}

extension TimerViewController {
    private func setupUI() {
        view.addGestureRecognizer(timerLongPress)
        view.addGestureRecognizer(timerTapGesture)
        
        view.backgroundColor = .white
        
        view.addSubview(scrambleLabel)
        view.addSubview(scrambleView)
        view.addSubview(timeLabel)
        view.addSubview(resultLabel)
        
        viewModel.cubeType = .five
        scrambleView.cubeType = viewModel.cubeType
    }
    
    private func layout() {
        scrambleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-TTUtils.bottomPadding(in: self) - 16)
        }
        
        scrambleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TTUtils.topPadding(in: self) + 16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
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

extension TimerViewController {
    private func makeTimerLongPressGesture() -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didStartTimer(_:)))
        longPress.minimumPressDuration = 0.3
        return longPress
    }
    
    private func makeTimerTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStopTimer(_:)))
        tapGesture.isEnabled = false
        return tapGesture
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
