//
//  TimeListViewController.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftUI
import Combine

class TimeListViewController: TTViewController {
    lazy private var collectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                 spacing: 16,
                                                                 isScrollEnabled: true)
    
    let viewModel = TimeListViewModel()
    var cancellableSet: Set<AnyCancellable> = []
    @Published var time: [TimeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layout()
        setupSubcriptions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
     
        view.addSubview(collectionView)
        
        setupCollectionView()
    }
    
    private func layout() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(TimeListViewCell.self, forCellWithReuseIdentifier: TimeListViewCell.reusableIdentifier)
        
        viewModel.time.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: TimeListViewCell.reusableIdentifier, cellType: TimeListViewCell.self)) { (index, element, cell) in
                cell.bind(timeItem: element)
            }.disposed(by: viewModel.bag)
        
        collectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
    
    private func setupSubcriptions() {
        cancellableSet = []
        
        $time
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTime in
                guard let self else { return }
                self.updateTime(newTime: newTime)
            }
            .store(in: &cancellableSet)
    }
    
    private func updateTime(newTime: [TimeItem]) {
        viewModel.timeList = newTime
        self.viewModel.time.accept(viewModel.timeList)
    }
}

extension TimeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TimeDetailViewController(context: .init(time: viewModel.time.value[indexPath.item]))
        self.navigateTo(vc)
    }
}

extension TimeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 64) / 3, height: 60)
    }
}
