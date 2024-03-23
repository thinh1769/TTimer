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
import FloatingPanel

class TimerViewController: TTViewController {
    lazy private var scrambleTypeButton = TTUtils.makeButton(title: "3x3",
                                                             textSize: 20,
                                                             backgroundColor: .lightGray,
                                                             cornerRadius: 8,
                                                             rightIcon: UIImage(systemName: "chevron.down"))
    lazy private var scrambleLabel = TTUtils.makeLabel(text: "",
                                                       size: 18,
                                                       color: .black,
                                                       textAlignment: .center)
    lazy private var timeLabel = TTUtils.makeLabel(text: "0.00",
                                                   size: 100,
                                                   color: .black,
                                                   textAlignment: .center)
    lazy private var mo3Label = TTUtils.makeLabel(text: "0.00",
                                                  size: TextSize.body.rawValue,
                                                  color: .black,
                                                  textAlignment: .center)
    lazy private var ao5Label = TTUtils.makeLabel(text: "0.00",
                                                  size: TextSize.body.rawValue,
                                                  color: .black,
                                                  textAlignment: .center)
    lazy private var ao12Label = TTUtils.makeLabel(text: "0.00",
                                                   size: TextSize.body.rawValue,
                                                   color: .black,
                                                   textAlignment: .center)
    lazy private var ao50Label = TTUtils.makeLabel(text: "0.00",
                                                   size: TextSize.body.rawValue,
                                                   color: .black,
                                                   textAlignment: .center)
    lazy private var countLabel = TTUtils.makeLabel(text: "0",
                                                    size: TextSize.body.rawValue,
                                                    color: .black,
                                                    textAlignment: .center)
    lazy private var timeTitleStackView = makeTimeTitleStackView()
    lazy private var timeStackView = makeTimeStackView()
    lazy private var timeResultStackView = makeTimeResultStackView()
    lazy private var scrambleTypeVC = ScrambleTypeViewController(selectedItem: viewModel.cubeType)
    
    lazy private var timerLongPress = makeTimerLongPressGesture()
    lazy private var timerTapGesture = makeTimerTapGesture()
    lazy private var scrambleView = ScrambleView()
    private let viewModel: TimerViewModel = .init()
    private var cancellableSet: Set<AnyCancellable> = []
    private let timer = TimerManager.shared
    @Published var time: [TimeItem] = []
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        parseData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.stopTimer()
        UIApplication.shared.isIdleTimerDisabled = true
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
            timer.startTimer(timeInterval: viewModel.timeInterval, target: self, selector: #selector(timerAction))
            timerTapGesture.isEnabled = true
            timerLongPress.isEnabled = false
            timeLabel.text = "SOLVE"
            timeLabel.textColor = .black
            handleHiddenWhenSolving(true)
        } else if gestureRecognizer.state == .began {
            impactFeedbackGenerator.impactOccurred()
            timeLabel.textColor = .green
        }
    }
    
    @objc func timerAction() {
        viewModel.currentTime += 1
    }
    
    @objc private func didTapStopTimer(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            timer.stopTimer()
            timeLabel.text = TTUtils.convertTime(viewModel.currentTime)
            timerTapGesture.isEnabled = false
            timerLongPress.isEnabled = true
            scrambleLabel.text = viewModel.generateScramble()
            viewModel.time.append(TimeItem(time: viewModel.currentTime,
                                           scramble: viewModel.currentScramble,
                                           createdDate: Date().toInt()))
            
            viewModel.count = viewModel.time.count
            handleHiddenWhenSolving(false)
        }
    }
    
    private func handleHiddenWhenSolving(_ isHidden: Bool) {
        scrambleTypeButton.isHidden = isHidden
        scrambleLabel.isHidden = isHidden
        scrambleView.isHidden = isHidden
        timeStackView.isHidden = isHidden
        timeTitleStackView.isHidden = isHidden
        tabBarController?.tabBar.isHidden = isHidden
    }
}

extension TimerViewController {
    private func setupUI() {
        view.addGestureRecognizer(timerLongPress)
        view.addGestureRecognizer(timerTapGesture)
        
        view.backgroundColor = .white
        
        view.addSubview(scrambleTypeButton)
        view.addSubview(scrambleLabel)
        view.addSubview(scrambleView)
        view.addSubview(timeLabel)
        view.addSubview(timeResultStackView)
        
        viewModel.cubeType = .three
        
        UIApplication.shared.isIdleTimerDisabled = true
        impactFeedbackGenerator.prepare()
        
        scrambleTypeButton.addTarget(self, action: #selector(showScrambleTypeBottomView), for: .touchUpInside)
        
        scrambleTypeVC.delegate = self
    }
    
    private func layout() {
        scrambleTypeButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(TTUtils.topPadding(in: self) + 16)
        }
        
        scrambleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-TTUtils.bottomPadding(in: self) - 16)
        }
        
        scrambleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrambleTypeButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        timeResultStackView.snp.makeConstraints { make in
            make.top.equalTo(scrambleView.snp.top)
            make.leading.equalTo(scrambleView.snp.trailing).offset(32)
        }
    }
    
    @objc private func showScrambleTypeBottomView() {
        let fpc = FloatingPanelController()
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 16
            return appearance
        }()
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        fpc.panGestureRecognizer.isEnabled = false
        
        fpc.layout = BottomSheetLayout(ratio: (scrambleTypeVC.preferredHeight + TTUtils.bottomPadding(in: self)) / UIScreen.main.bounds.height)
        fpc.set(contentViewController: scrambleTypeVC)
        self.present(fpc, animated: true)
    }
    
    private func setupSubscription() {
        cancellableSet = []
        
        viewModel.$cubeType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cubeType in
                guard let self else { return }
                self.scrambleView.cubeType = cubeType
                self.scrambleLabel.text = self.viewModel.generateScramble()
            }
            .store(in: &cancellableSet)
        
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
        
        viewModel.$mo3
            .receive(on: DispatchQueue.main)
            .sink { [weak self] mo3 in
                guard let self else { return }
                self.mo3Label.text = TTUtils.convertTime(mo3)
            }
            .store(in: &cancellableSet)
        
        viewModel.$ao5
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ao5 in
                guard let self else { return }
                self.ao5Label.text = TTUtils.convertTime(ao5)
            }
            .store(in: &cancellableSet)
        
        viewModel.$ao12
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ao12 in
                guard let self else { return }
                self.ao12Label.text = TTUtils.convertTime(ao12)
            }
            .store(in: &cancellableSet)
        
        viewModel.$ao50
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ao50 in
                guard let self else { return }
                self.ao50Label.text = TTUtils.convertTime(ao50)
            }
            .store(in: &cancellableSet)
        
        viewModel.$count
            .receive(on: DispatchQueue.main)
            .sink { [weak self] count in
                guard let self else { return }
                self.countLabel.text = String(count)
                self.viewModel.calculateTime()
            }
            .store(in: &cancellableSet)
    }
}

extension TimerViewController {
    private func makeTimerLongPressGesture() -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didStartTimer(_:)))
        longPress.minimumPressDuration = 0.1
        return longPress
    }
    
    private func makeTimerTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStopTimer(_:)))
        tapGesture.isEnabled = false
        return tapGesture
    }
    
    private func makeTimeStackView() -> UIStackView {
        let stackView = UIStackView(views: [mo3Label, ao5Label, ao12Label, ao50Label, countLabel],
                                    axis: .vertical,
                                    spacing: 4)
        return stackView
    }
    
    private func makeTimeTitleStackView() -> UIStackView {
        let mo3Title = TTUtils.makeLabel(text: "Mo3:",
                                         size: TextSize.body.rawValue,
                                         color: .black,
                                         textAlignment: .center,
                                         isBold: true)
        let ao5Title = TTUtils.makeLabel(text: "Ao5:",
                                         size: TextSize.body.rawValue,
                                         color: .black,
                                         textAlignment: .center,
                                         isBold: true)
        let ao12Title = TTUtils.makeLabel(text: "Ao12:",
                                          size: TextSize.body.rawValue,
                                          color: .black,
                                          textAlignment: .center,
                                          isBold: true)
        let ao50Title = TTUtils.makeLabel(text: "Ao50:",
                                          size: TextSize.body.rawValue,
                                          color: .black,
                                          textAlignment: .center,
                                          isBold: true)
        let countTitle = TTUtils.makeLabel(text: "Count:",
                                           size: TextSize.body.rawValue,
                                           color: .black,
                                           textAlignment: .center,
                                           isBold: true)
        
        let stackView = UIStackView(views: [mo3Title, ao5Title, ao12Title, ao50Title, countTitle],
                                    axis: .vertical,
                                    spacing: 4)
        return stackView
    }
    
    private func makeTimeResultStackView() -> UIStackView {
        let stackView = UIStackView(views: [timeTitleStackView, timeStackView],
                                    axis: .horizontal,
                                    spacing: 8)
        return stackView
    }
}

extension TimerViewController: ScrambleTypeViewControllerDelegate {
    func didSelectItem(_ item: CubeType) {
        scrambleTypeButton.setTitle(TTUtils.getCubeTypeString(item), for: .normal)
        viewModel.cubeType = item
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
