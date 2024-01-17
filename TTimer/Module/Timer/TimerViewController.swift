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
    lazy private var whiteCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                      spacing: 0,
                                                                      isScrollEnabled: false)
    lazy private var greenCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                      spacing: 0,
                                                                      isScrollEnabled: false)
    lazy private var yellowCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                       spacing: 0,
                                                                       isScrollEnabled: false)
    lazy private var orangeCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                       spacing: 0,
                                                                       isScrollEnabled: false)
    lazy private var redCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                    spacing: 0,
                                                                    isScrollEnabled: false)
    lazy private var blueCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                     spacing: 0,
                                                                     isScrollEnabled: false)
    
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
        viewModel.cubeType = .six
//        viewModel.turnU(.third)
//        viewModel.turnU(.second)
//        viewModel.turnU()
//        viewModel.turnF(layer: .three)
//        viewModel.turnL(layer: .three)
//        viewModel.turnR(layer: .three)
//        viewModel.turnD(layer: .three)
        viewModel.turnU(isPrime: true)
        updateData()
    }

    private func updateData() {
        var combinedBlueData: [[PieceColor]] = []
        var combinedWhiteData: [[PieceColor]] = []
        var combinedGreenData: [[PieceColor]] = []
        var combinedRedData: [[PieceColor]] = []
        var combinedOrangeData: [[PieceColor]] = []
        var combinedYellowData: [[PieceColor]] = []
        
        for index in 0...viewModel.indexCubeType {
            combinedBlueData.append(viewModel.blue[index])
            combinedWhiteData.append(viewModel.white[index])
            combinedGreenData.append(viewModel.green[index])
            combinedRedData.append(viewModel.red[index])
            combinedOrangeData.append(viewModel.orange[index])
            combinedYellowData.append(viewModel.yellow[index])
        }
        viewModel.blueData.accept(combinedBlueData.flatMap { $0 })
        viewModel.whiteData.accept(combinedWhiteData.flatMap { $0 })
        viewModel.greenData.accept(combinedGreenData.flatMap { $0 })
        viewModel.redData.accept(combinedRedData.flatMap { $0 })
        viewModel.orangeData.accept(combinedOrangeData.flatMap { $0 })
        viewModel.yellowData.accept(combinedYellowData.flatMap { $0 })
    }
    
    @objc private func didTapGenerateScramble() {
        scrambleLabel.text = viewModel.generateRandomScrambleList()
        
        updateData()
    }
}

extension TimerViewController {
    private func setupUI() {
        didTapGenerateScramble()
        generateScrambleBtn.addTarget(self, action: #selector(didTapGenerateScramble), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        view.addSubview(scrambleLabel)
        view.addSubview(generateScrambleBtn)
        
        view.addSubview(whiteCollectionView)
        view.addSubview(greenCollectionView)
        view.addSubview(yellowCollectionView)
        view.addSubview(orangeCollectionView)
        view.addSubview(redCollectionView)
        view.addSubview(blueCollectionView)
        
        setupWhiteCollectionView()
        setupGreenCollectionView()
        setupYellowCollectionView()
        setupOrangeCollectionView()
        setupRedCollectionView()
        setupBlueCollectionView()
    }
    
    private func layout() {
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
        
        blueCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(viewModel.cubeSize)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-viewModel.cubeSize-10-TTUtils.bottomPadding(in: self))
        }
        
        redCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(viewModel.cubeSize)
            make.trailing.equalTo(blueCollectionView.snp.leading).offset(-4)
            make.centerY.equalTo(blueCollectionView)
        }
        
        greenCollectionView.snp.makeConstraints { make in
            make.width.height.equalTo(viewModel.cubeSize)
            make.centerY.equalTo(redCollectionView)
            make.trailing.equalTo(redCollectionView.snp.leading).offset(-4)
        }
        
        yellowCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(viewModel.cubeSize)
            make.centerX.equalTo(greenCollectionView)
            make.top.equalTo(greenCollectionView.snp.bottom).offset(4)
        }
        
        orangeCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(viewModel.cubeSize)
            make.trailing.equalTo(greenCollectionView.snp.leading).offset(-4)
            make.centerY.equalTo(greenCollectionView)
        }
        
        whiteCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(viewModel.cubeSize)
            make.centerX.equalTo(greenCollectionView)
            make.bottom.equalTo(greenCollectionView.snp.top).offset(-4)
        }
    }
    
    private func setupGreenCollectionView() {
        greenCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.greenData.asObservable()
            .bind(to: greenCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        greenCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupWhiteCollectionView() {
        whiteCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.whiteData.asObservable()
            .bind(to: whiteCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        whiteCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupYellowCollectionView() {
        yellowCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.yellowData.asObservable()
            .bind(to: yellowCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        yellowCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupOrangeCollectionView() {
        orangeCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.orangeData.asObservable()
            .bind(to: orangeCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        orangeCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupRedCollectionView() {
        redCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.redData.asObservable()
            .bind(to: redCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        redCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupBlueCollectionView() {
        blueCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        viewModel.blueData.asObservable()
            .bind(to: blueCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: viewModel.bag)
        
        blueCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
}

extension TimerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModel.cubeSize / CGFloat(viewModel.cubeType.rawValue), height: viewModel.cubeSize / CGFloat(viewModel.cubeType.rawValue))
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
