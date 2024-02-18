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

class TimeListViewController: TTViewController {
    lazy private var collectionView = TTUtils.makeCollectionView(scrollDirection: .vertical,
                                                                 spacing: 0,
                                                                 isScrollEnabled: false)
    
    let viewModel = TimeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layout()
    }
    
    private func setupUI() {
        view.backgroundColor = .brown
     
        view.addSubview(collectionView)
        
        setupCollectionView()
        
        viewModel.time.accept(["10.89", "12.90"])
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
                cell.bind(time: element)
            }.disposed(by: viewModel.bag)
        
        collectionView.rx.setDelegate(self).disposed(by: viewModel.bag)
    }
}

extension TimeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
}
