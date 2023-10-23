//
//  ViewController.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import UIKit
import SnapKit

class TimerViewController: TTViewController {
    lazy private var whiteCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    lazy private var greenCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    lazy private var yellowCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    lazy private var orangeCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    lazy private var redCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    lazy private var blueCollectionView = TTUtils.makeCollectionView(scrollDirection: .vertical, spacing: 0, isScrollEnabled: false)
    
    private let viewModel = TimerViewModel()
    
    let scramble = ["U"]
    
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
        viewModel.uTurn()
        viewModel.uTurn()
        
        viewModel.blueData.accept(viewModel.blue[0] + viewModel.blue[1] + viewModel.blue[2])
        viewModel.whiteData.accept(viewModel.white[0] + viewModel.white[1] + viewModel.white[2])
        viewModel.greenData.accept(viewModel.green[0] + viewModel.green[1] + viewModel.green[2])
        viewModel.yellowData.accept(viewModel.yellow[0] + viewModel.yellow[1] + viewModel.yellow[2])
        viewModel.redData.accept(viewModel.red[0] + viewModel.red[1] + viewModel.red[2])
        viewModel.orangeData.accept(viewModel.orange[0] + viewModel.orange[1] + viewModel.orange[2])
    }

}

extension TimerViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
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
        blueCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-30-10-TTUtils.bottomPadding(in: self))
        }
        
        redCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.trailing.equalTo(blueCollectionView.snp.leading).offset(-4)
            make.centerY.equalTo(blueCollectionView)
        }
        
        greenCollectionView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalTo(redCollectionView)
            make.trailing.equalTo(redCollectionView.snp.leading).offset(-4)
        }
        
        yellowCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.centerX.equalTo(greenCollectionView)
            make.top.equalTo(greenCollectionView.snp.bottom).offset(4)
        }
        
        orangeCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.trailing.equalTo(greenCollectionView.snp.leading).offset(-4)
            make.centerY.equalTo(greenCollectionView)
        }
        
        whiteCollectionView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
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
        return CGSize(width: 10, height: 10)
    }
}

