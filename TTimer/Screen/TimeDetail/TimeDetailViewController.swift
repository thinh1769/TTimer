//
//  TimeDetailViewController.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 24/03/2024.
//

import UIKit
import SnapKit

class TimeDetailViewController: TTViewController {
    private lazy var timeLabel = TTUtils.makeLabel(text: "",
                                                   size: TextSize.title.rawValue,
                                                   color: .black)
    private lazy var scrambleLabel = TTUtils.makeLabel(text: "",
                                                       size: TextSize.body.rawValue,
                                                       color: .black)
    private lazy var createDateLabel = TTUtils.makeLabel(text: "",
                                                         size: TextSize.smallBody.rawValue,
                                                         color: .gray)
    
    typealias ViewModel = TimeDetailViewModel
    private var viewModel: ViewModel
    
    init(context: ViewModel.Context) {
        self.viewModel = .init(context: context)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscriptions()
        parseData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(timeLabel)
        view.addSubview(scrambleLabel)
        view.addSubview(createDateLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        scrambleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(scrambleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setupSubscriptions() {
        
    }
    
    private func parseData() {
        timeLabel.text = TTUtils.convertTime(viewModel.context.time.time)
        scrambleLabel.text = String().getScramble(viewModel.context.time.scramble)
        createDateLabel.text = viewModel.context.time.createdDate.stringDate(withFormat: "HH:mm:ss dd-MM-yyyy")
    }
}
