//
//  ScrambleView.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 20/01/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import SwiftUI

class ScrambleView: UIView {
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
    
    var white: [[PieceColor]] = Array(repeating: Array(repeating: .white, count: 3), count: 3)
    var green: [[PieceColor]] = Array(repeating: Array(repeating: .green, count: 3), count: 3)
    var yellow: [[PieceColor]] = Array(repeating: Array(repeating: .yellow, count: 3), count: 3)
    var orange: [[PieceColor]] = Array(repeating: Array(repeating: .orange, count: 3), count: 3)
    var red: [[PieceColor]] = Array(repeating: Array(repeating: .red, count: 3), count: 3)
    var blue: [[PieceColor]] = Array(repeating: Array(repeating: .blue, count: 3), count: 3)
    
    let whiteData = BehaviorRelay<[PieceColor]>(value: [])
    let greenData = BehaviorRelay<[PieceColor]>(value: [])
    let yellowData = BehaviorRelay<[PieceColor]>(value: [])
    let orangeData = BehaviorRelay<[PieceColor]>(value: [])
    let redData = BehaviorRelay<[PieceColor]>(value: [])
    let blueData = BehaviorRelay<[PieceColor]>(value: [])
    
    var turnUp: TurnUService?
    var turnFront: TurnFService?
    var turnLeft: TurnLService?
    var turnRight: TurnRService?
    var turnDown: TurnDService?
    var turnBack: TurnBService?
    
    let bag = DisposeBag()
    var cubeSize: CGFloat
    var indexCubeType: Int
    var cubeType: CubeType {
        didSet {
            resetAllFacesColor()
            updateCubeSize()
            indexCubeType = cubeType.rawValue - 1
            
            turnUp = .init(mainFace: white,
                           face1: green,
                           face2: orange,
                           face3: blue,
                           face4: red,
                           cubeType: cubeType)
            
            turnFront = .init(mainFace: green,
                              face1: yellow,
                              face2: orange,
                              face3: white,
                              face4: red,
                              cubeType: cubeType)
            
            turnLeft = .init(mainFace: orange,
                             face1: green,
                             face2: yellow,
                             face3: blue,
                             face4: white,
                             cubeType: cubeType)
            
            turnRight = .init(mainFace: red,
                              face1: green,
                              face2: white,
                              face3: blue,
                              face4: yellow,
                              cubeType: cubeType)
            
            turnDown = .init(mainFace: yellow,
                             face1: blue,
                             face2: orange,
                             face3: green,
                             face4: red,
                             cubeType: cubeType)
            
            turnBack = .init(mainFace: blue,
                             face1: white,
                             face2: orange,
                             face3: yellow,
                             face4: red,
                             cubeType: cubeType)
        }
    }
    
    override init(frame: CGRect) {
        cubeSize = 40
        cubeType = CubeType.three
        indexCubeType = cubeType.rawValue - 1
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        cubeSize = 40
        cubeType = .three
        indexCubeType = cubeType.rawValue - 1
        super.init(coder: coder)
    }
    
    func updateData() {
        var combinedBlueData: [[PieceColor]] = []
        var combinedWhiteData: [[PieceColor]] = []
        var combinedGreenData: [[PieceColor]] = []
        var combinedRedData: [[PieceColor]] = []
        var combinedOrangeData: [[PieceColor]] = []
        var combinedYellowData: [[PieceColor]] = []
        
        for index in 0...(cubeType.rawValue - 1) {
            combinedBlueData.append(blue[index])
            combinedWhiteData.append(white[index])
            combinedGreenData.append(green[index])
            combinedRedData.append(red[index])
            combinedOrangeData.append(orange[index])
            combinedYellowData.append(yellow[index])
        }
        blueData.accept(combinedBlueData.flatMap { $0 })
        whiteData.accept(combinedWhiteData.flatMap { $0 })
        greenData.accept(combinedGreenData.flatMap { $0 })
        redData.accept(combinedRedData.flatMap { $0 })
        orangeData.accept(combinedOrangeData.flatMap { $0 })
        yellowData.accept(combinedYellowData.flatMap { $0 })
    }
    
    func resetAllFacesColor() {
        white = Array(repeating: Array(repeating: .white, count: cubeType.rawValue), count: cubeType.rawValue)
        green = Array(repeating: Array(repeating: .green, count: cubeType.rawValue), count: cubeType.rawValue)
        yellow = Array(repeating: Array(repeating: .yellow, count: cubeType.rawValue), count: cubeType.rawValue)
        orange = Array(repeating: Array(repeating: .orange, count: cubeType.rawValue), count: cubeType.rawValue)
        red = Array(repeating: Array(repeating: .red, count: cubeType.rawValue), count: cubeType.rawValue)
        blue = Array(repeating: Array(repeating: .blue, count: cubeType.rawValue), count: cubeType.rawValue)
    }
    
    func updateCubeSize() {
        switch cubeType {
        case .two:
            cubeSize = PieceSize.two.rawValue * CGFloat(cubeType.rawValue)
        case .three:
            cubeSize = PieceSize.three.rawValue * CGFloat(cubeType.rawValue)
        case .four:
            cubeSize = PieceSize.four.rawValue * CGFloat(cubeType.rawValue)
        case .five:
            cubeSize = PieceSize.five.rawValue * CGFloat(cubeType.rawValue)
        case .six:
            cubeSize = PieceSize.six.rawValue * CGFloat(cubeType.rawValue)
        case .seven:
            cubeSize = PieceSize.seven.rawValue * CGFloat(cubeType.rawValue)
        }
        
        layoutSubviews()
    }
    
    func turnScramble(_ scrambleCharacter: String) {
        switch scrambleCharacter {
            /// U
        case Scramble.U.rawValue:
            turnU()
        case Scramble.UPrime.rawValue:
            turnU(isPrime: true)
        case Scramble.U2.rawValue:
            turnU(isTwo: true)
            
            /// Uw
        case Scramble2Layers.Uw.rawValue:
            turnU(layer: .two)
            return
        case Scramble2Layers.UwPrime.rawValue:
            turnU(layer: .two,
                  isPrime: true)
            return
        case Scramble2Layers.Uw2.rawValue:
            turnU(layer: .two,
                  isTwo: true)
            return
            
            ///3Uw
        case Scramble3Layers._3Uw.rawValue:
            turnU(layer: .three)
            return
        case Scramble3Layers._3UwPrime.rawValue:
            turnU(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Uw2.rawValue:
            turnU(layer: .three,
                  isTwo: true)
            
            /// F
        case Scramble.F.rawValue:
            turnF()
        case Scramble.FPrime.rawValue:
            turnF(isPrime: true)
        case Scramble.F2.rawValue:
            turnF(isTwo: true)
            
            /// Fw
        case Scramble2Layers.Fw.rawValue:
            turnF(layer: .two)
        case Scramble2Layers.FwPrime.rawValue:
            turnF(layer: .two,
                  isPrime: true)
        case Scramble2Layers.Fw2.rawValue:
            turnF(layer: .two,
                  isTwo: true)
            
            ///3Fw
        case Scramble3Layers._3Fw.rawValue:
            turnF(layer: .three)
            return
        case Scramble3Layers._3FwPrime.rawValue:
            turnF(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Fw2.rawValue:
            turnF(layer: .three,
                  isTwo: true)
            
            /// L
        case Scramble.L.rawValue:
            turnL()
        case Scramble.LPrime.rawValue:
            turnL(isPrime: true)
        case Scramble.L2.rawValue:
            turnL(isTwo: true)
            
            /// Lw
        case Scramble2Layers.Lw.rawValue:
            turnL(layer: .two)
        case Scramble2Layers.LwPrime.rawValue:
            turnL(layer: .two,
                  isPrime: true)
        case Scramble2Layers.Lw2.rawValue:
            turnL(layer: .two,
                  isTwo: true)
            
            ///3Lw
        case Scramble3Layers._3Lw.rawValue:
            turnL(layer: .three)
            return
        case Scramble3Layers._3LwPrime.rawValue:
            turnL(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Lw2.rawValue:
            turnL(layer: .three,
                  isTwo: true)
            
            /// R
        case Scramble.R.rawValue:
            turnR()
        case Scramble.RPrime.rawValue:
            turnR(isPrime: true)
        case Scramble.R2.rawValue:
            turnR(isTwo: true)
            
            /// Rw
        case Scramble2Layers.Rw.rawValue:
            turnR(layer: .two)
        case Scramble2Layers.RwPrime.rawValue:
            turnR(layer: .two,
                  isPrime: true)
        case Scramble2Layers.Rw2.rawValue:
            turnR(layer: .two,
                  isTwo: true)
            
            ///3Rw
        case Scramble3Layers._3Rw.rawValue:
            turnR(layer: .three)
            return
        case Scramble3Layers._3RwPrime.rawValue:
            turnR(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Rw2.rawValue:
            turnR(layer: .three,
                  isTwo: true)
            
            /// D
        case Scramble.D.rawValue:
            turnD()
        case Scramble.DPrime.rawValue:
            turnD(isPrime: true)
        case Scramble.D2.rawValue:
            turnD(isTwo: true)
            
            /// Dw
        case Scramble2Layers.Dw.rawValue:
            turnD(layer: .two)
        case Scramble2Layers.DwPrime.rawValue:
            turnD(layer: .two,
                  isPrime: true)
        case Scramble2Layers.Dw2.rawValue:
            turnD(layer: .two,
                  isTwo: true)
            
            ///3Dw
        case Scramble3Layers._3Dw.rawValue:
            turnD(layer: .three)
            return
        case Scramble3Layers._3DwPrime.rawValue:
            turnD(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Dw2.rawValue:
            turnD(layer: .three,
                  isTwo: true)
            
            /// B
        case Scramble.B.rawValue:
            turnB()
        case Scramble.BPrime.rawValue:
            turnB(isPrime: true)
        case Scramble.B2.rawValue:
            turnB(isTwo: true)
            
            /// Bw
        case Scramble2Layers.Bw.rawValue:
            turnB(layer: .two)
        case Scramble2Layers.BwPrime.rawValue:
            turnB(layer: .two,
                  isPrime: true)
        case Scramble2Layers.Bw2.rawValue:
            turnB(layer: .two,
                  isTwo: true)
            
            ///3Bw
        case Scramble3Layers._3Bw.rawValue:
            turnB(layer: .three)
            return
        case Scramble3Layers._3BwPrime.rawValue:
            turnB(layer: .three,
                  isPrime: true)
            return
        case Scramble3Layers._3Bw2.rawValue:
            turnB(layer: .three,
                  isTwo: true)
        default:
            return
        }
    }
    
    func turnU(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnUp?.turnU(layer,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .white)
    }
    
    func turnF(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnFront?.turnF(layer,
                                            isPrime: isPrime,
                                            isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .green)
    }
    
    func turnL(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnLeft?.turnL(layer,
                                           isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .orange)
    }
    
    func turnR(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnRight?.turnR(layer,
                                            isPrime: isPrime,
                                            isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .red)
    }
    
    func turnD(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnDown?.turnD(layer,
                                           isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .yellow)
    }
    
    func turnB(layer: Layer = .one,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnBack?.turnB(layer,
                                           isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .blue)
    }
    
    private func reassignFace(_ result: SwapResult,
                              face: FaceColor)
    {
        switch face {
        case .white:
            if let mainFaceResult = result.mainFace {
                white = mainFaceResult
            }
            green = result.face1
            orange = result.face2
            blue = result.face3
            red = result.face4
            
        case .green:
            if let mainFaceResult = result.mainFace {
                green = mainFaceResult
            }
            yellow = result.face1
            orange = result.face2
            white = result.face3
            red = result.face4
            
        case .yellow:
            if let mainFaceResult = result.mainFace {
                yellow = mainFaceResult
            }
            blue = result.face1
            orange = result.face2
            green = result.face3
            red = result.face4
            
        case .orange:
            if let mainFaceResult = result.mainFace {
                orange = mainFaceResult
            }
            green = result.face1
            yellow = result.face2
            blue = result.face3
            white = result.face4
            
        case .red:
            if let mainFaceResult = result.mainFace {
                red = mainFaceResult
            }
            green = result.face1
            white = result.face2
            blue = result.face3
            yellow = result.face4
            
        case .blue:
            if let mainFaceResult = result.mainFace {
                blue = mainFaceResult
            }
            white = result.face1
            orange = result.face2
            yellow = result.face3
            red = result.face4
        }
        
        if face != .white {
            turnUp?.reassignFace(SwapResult(mainFace: white,
                                            face1: green,
                                            face2: orange,
                                            face3: blue,
                                            face4: red))
        }
        
        if face != .green {
            turnFront?.reassignFace(SwapResult(mainFace: green,
                                               face1: yellow,
                                               face2: orange,
                                               face3: white,
                                               face4: red))
        }
        
        if face != .orange {
            turnLeft?.reassignFace(SwapResult(mainFace: orange,
                                              face1: green,
                                              face2: yellow,
                                              face3: blue,
                                              face4: white))
        }
        
        if face != .red {
            turnRight?.reassignFace(SwapResult(mainFace: red,
                                               face1: green,
                                               face2: white,
                                               face3: blue,
                                               face4: yellow))
        }
        
        if face != .yellow {
            turnDown?.reassignFace(SwapResult(mainFace: yellow,
                                              face1: blue,
                                              face2: orange,
                                              face3: green,
                                              face4: red))
        }
        
        if face != .blue {
            turnBack?.reassignFace(SwapResult(mainFace: blue,
                                              face1: white,
                                              face2: orange,
                                              face3: yellow,
                                              face4: red))
        }
        updateData()
    }
}

extension ScrambleView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func setupUI() {
        addSubview(whiteCollectionView)
        addSubview(greenCollectionView)
        addSubview(yellowCollectionView)
        addSubview(orangeCollectionView)
        addSubview(redCollectionView)
        addSubview(blueCollectionView)
        
        setupWhiteCollectionView()
        setupGreenCollectionView()
        setupYellowCollectionView()
        setupOrangeCollectionView()
        setupRedCollectionView()
        setupBlueCollectionView()
        
        updateData()
    }
    
    private func layout() {
        blueCollectionView.snp.remakeConstraints { make in
            make.height.width.equalTo(cubeSize)
            make.trailing.equalToSuperview()
        }
        
        redCollectionView.snp.remakeConstraints { make in
            make.height.width.equalTo(cubeSize)
            make.trailing.equalTo(blueCollectionView.snp.leading).offset(-4)
            make.centerY.equalTo(blueCollectionView)
        }
        
        greenCollectionView.snp.remakeConstraints { make in
            make.width.height.equalTo(cubeSize)
            make.centerY.equalTo(redCollectionView)
            make.trailing.equalTo(redCollectionView.snp.leading).offset(-4)
        }
        
        yellowCollectionView.snp.remakeConstraints { make in
            make.height.width.equalTo(cubeSize)
            make.centerX.equalTo(greenCollectionView)
            make.top.equalTo(greenCollectionView.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
        
        orangeCollectionView.snp.remakeConstraints { make in
            make.height.width.equalTo(cubeSize)
            make.trailing.equalTo(greenCollectionView.snp.leading).offset(-4)
            make.leading.equalToSuperview()
            make.centerY.equalTo(greenCollectionView)
        }
        
        whiteCollectionView.snp.remakeConstraints { make in
            make.height.width.equalTo(cubeSize)
            make.centerX.equalTo(greenCollectionView)
            make.bottom.equalTo(greenCollectionView.snp.top).offset(-4)
            make.top.equalToSuperview()
        }
    }
}

extension ScrambleView {
    private func setupGreenCollectionView() {
        greenCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        greenData.asObservable()
            .bind(to: greenCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        greenCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupWhiteCollectionView() {
        whiteCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        whiteData.asObservable()
            .bind(to: whiteCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        whiteCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupYellowCollectionView() {
        yellowCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        yellowData.asObservable()
            .bind(to: yellowCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        yellowCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupOrangeCollectionView() {
        orangeCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        orangeData.asObservable()
            .bind(to: orangeCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        orangeCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupRedCollectionView() {
        redCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        redData.asObservable()
            .bind(to: redCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        redCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func setupBlueCollectionView() {
        blueCollectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.reusableIdentifier)
        
        blueData.asObservable()
            .bind(to: blueCollectionView.rx.items(cellIdentifier: PieceViewCell.reusableIdentifier, cellType: PieceViewCell.self)) { (index, element, cell) in
                cell.config(color: element)
            }.disposed(by: bag)
        
        blueCollectionView.rx.setDelegate(self).disposed(by: bag)
    }
}

extension ScrambleView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cubeSize / CGFloat(cubeType.rawValue), height: cubeSize / CGFloat(cubeType.rawValue))
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
