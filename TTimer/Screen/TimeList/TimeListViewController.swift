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
                                                                 spacing: 0,
                                                                 isScrollEnabled: false)
    
    let viewModel = TimeListViewModel()
    var cancellableSet: Set<AnyCancellable> = []
    @Published var time: TimeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layout()
        setupSubcriptions()
    }
    
    private func setupUI() {
        view.backgroundColor = .brown
     
        view.addSubview(collectionView)
        
        setupCollectionView()
    }
    
    private func layout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
                guard let self,
                      let newTime
                else { return }
                self.updateTime(newTime: newTime)
            }
            .store(in: &cancellableSet)
    }
    
    private func updateTime(newTime: TimeItem) {
        viewModel.timeList.append(newTime)
        self.viewModel.time.accept(viewModel.timeList)
    }
}

extension TimeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
}
