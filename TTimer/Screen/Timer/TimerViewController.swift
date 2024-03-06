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
    private let timer = TimerManager.shared
    var secondsString: [String] = []
    @Published var time: TimeItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.stopTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscription()
        scrambleLabel.text = viewModel.generateScramble()
        secondsString = generateSecond()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    private func parseData() {
    }
    
    private func generateSecond() -> [String] {
        var numberStrings: [String] = []

        for i in 1...1000 {
            let number = Double(i) / 100.0
            let formattedString = String(format: "%.2f", number)
            numberStrings.append(formattedString)
        }
        
        return numberStrings
    }
    
    @objc private func didStartTimer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            viewModel.previousTime = viewModel.currentTime
            resultLabel.text = TTUtils.convertTime(viewModel.previousTime)
            viewModel.currentTime = 0
            timer.startTimer(timeInterval: viewModel.timeInterval, target: self, selector: #selector(timerAction))
            timerTapGesture.isEnabled = true
            timerLongPress.isEnabled = false
            timeLabel.text = "SOLVE"
        }
    }
    
    @objc func timerAction() {
        viewModel.currentTime += 1
        timeLabel.text = TTUtils.convertTime(viewModel.currentTime)
    }
    
    @objc private func didTapStopTimer(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            timer.stopTimer()
            timeLabel.text = TTUtils.convertTime(viewModel.currentTime)
            timerTapGesture.isEnabled = false
            timerLongPress.isEnabled = true
            scrambleLabel.text = viewModel.generateScramble()
            viewModel.time = TimeItem(time: viewModel.currentTime,
                                      scramble: viewModel.currentScramble,
                                      createdDate: Date().toInt())
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
        
        viewModel.$time
            .receive(on: DispatchQueue.main)
            .sink { [weak self] time in
                guard let self else { return }
                self.time = time
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
