import UIKit
import Combine
import SnapKit
import CombineCocoa

protocol ScrambleTypeBottomViewDelegate: AnyObject {
    func dismissPopup()
    func didSelectItem(_ item: CubeType)
}

class ScrambleTypeBottomView: UIView {
    private lazy var okButton = TTUtils.makeButton(title: "OK",
                                                   backgroundColor: .link,
                                                   cornerRadius: 8)
    private lazy var cancelButton = TTUtils.makeButton(title: "Cancel",
                                                       backgroundColor: .white,
                                                       cornerRadius: 8, 
                                                       borderColor: UIColor.link.cgColor,
                                                       borderWidth: 1)
    private let pickerView = UIPickerView()
    
    weak var delegate: ScrambleTypeBottomViewDelegate?
    private var cancellableSet: Set<AnyCancellable> = .init()
    private let items = CubeType.allCases
    private var selectedItem = CubeType.three
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupSubscriptions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupSubView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        
        addSubview(pickerView)
        addSubview(okButton)
        addSubview(cancelButton)
        
        let buttonWidth = (self.bounds.width - 16 * 3) / 2
        okButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(buttonWidth)
            make.leading.equalTo(16)
            make.bottom.equalTo(-16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(buttonWidth)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-16)
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(okButton.snp.top).offset(-16)
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
                self.delegate?.dismissPopup()
            }
            .store(in: &cancellableSet)
        
        cancelButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.delegate?.dismissPopup()
            }
            .store(in: &cancellableSet)
    }
    
}

extension ScrambleTypeBottomView: UIPickerViewDelegate, UIPickerViewDataSource {
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
