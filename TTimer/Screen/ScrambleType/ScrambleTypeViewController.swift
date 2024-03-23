//
//  ScrambleTypeViewController.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 23/03/2024.
//

import UIKit
import Combine
import SnapKit
import CombineCocoa

protocol ScrambleTypeViewControllerDelegate: AnyObject {
    func didSelectItem(_ item: CubeType)
}
class ScrambleTypeViewController: TTViewController {
    public let preferredHeight: CGFloat = 265
    
    private lazy var okButton = TTUtils.makeButton(title: "OK",
                                                   backgroundColor: .link,
                                                   cornerRadius: 8)
    private let pickerView = UIPickerView()
    
    weak var delegate: ScrambleTypeViewControllerDelegate?
    private var cancellableSet: Set<AnyCancellable> = .init()
    private let items = CubeType.allCases
    private var selectedItem = CubeType.three
    
    init(selectedItem: CubeType) {
        self.selectedItem = selectedItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubscriptions()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        view.addSubview(pickerView)
        view.addSubview(okButton)
        
        pickerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(okButton.snp.top).offset(-16)
        }
        
        okButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(pickerView.snp.bottom).offset(20)
        }
    }
    
    func setupSubscriptions() {
        cancellableSet = []
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        okButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.delegate?.didSelectItem(selectedItem)
                self.dismiss(animated: true)
            }
            .store(in: &cancellableSet)
    }
}

extension ScrambleTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TTUtils.getCubeTypeString(items[row])
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = TTUtils.getCubeTypeString(items[row])
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
    }
}
