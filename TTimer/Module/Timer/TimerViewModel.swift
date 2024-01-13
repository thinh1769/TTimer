//
//  TimerViewModel.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift
import SwiftUI

class TimerViewModel {
    var turnUp: TurnUService?
    var turnFront: TurnFService?
    var turnLeft: TurnLService?
    var turnRight: TurnRService?
    var turnDown: TurnDService?
    var turnBack: TurnBService?
    
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
    
    let bag = DisposeBag()
    var scrambleList: [String]
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
    
    init() {
        scrambleList = [""]
        cubeSize = 40
        cubeType = CubeType.two
        indexCubeType = cubeType.rawValue - 1
    }
    
    private func resetAllFacesColor() {
        white = Array(repeating: Array(repeating: .white, count: cubeType.rawValue), count: cubeType.rawValue)
        green = Array(repeating: Array(repeating: .green, count: cubeType.rawValue), count: cubeType.rawValue)
        yellow = Array(repeating: Array(repeating: .yellow, count: cubeType.rawValue), count: cubeType.rawValue)
        orange = Array(repeating: Array(repeating: .orange, count: cubeType.rawValue), count: cubeType.rawValue)
        red = Array(repeating: Array(repeating: .red, count: cubeType.rawValue), count: cubeType.rawValue)
        blue = Array(repeating: Array(repeating: .blue, count: cubeType.rawValue), count: cubeType.rawValue)
    }
    
    private func updateCubeSize() {
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
    }
    
    func generateRandomScrambleList() -> String {
        resetAllFacesColor()
        
        var scramble = ""
        var length = 0
        let allScramble = Scramble.allCases
        let allScramble2Layers = Scramble2Layers.allCases
        let allScramble3Layers = Scramble3Layers.allCases
        
        var combinedCase = allScramble.map { "\($0.rawValue)" }
        var usedScrambleCharacter = ""
        
        switch cubeType {
        case .two:
            length = ScrambleLength.two.rawValue
        case .three:
            length = ScrambleLength.three.rawValue
        case .four:
            length = ScrambleLength.four.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
        case .five:
            length = ScrambleLength.five.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
        case .six:
            length = ScrambleLength.six.rawValue
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        case .seven:
            length = ScrambleLength.seven.rawValue
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        }
        
        while length > 0 {
            let randomScramble = combinedCase.randomElement() ?? ""
            if !randomScramble.contains(usedScrambleCharacter) {
                scramble += "\(randomScramble) "
                scrambleList.append(randomScramble)
                turnScramble(randomScramble)
                usedScrambleCharacter = randomScramble.filter { $0.isUppercase }
                length -= 1
            }
        }
        
        return String(scramble.dropLast())
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
            turnU(is2Layers: true)
        case Scramble2Layers.UwPrime.rawValue:
            turnU(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Uw2.rawValue:
            turnU(is2Layers: true,
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
            turnF(is2Layers: true)
        case Scramble2Layers.FwPrime.rawValue:
            turnF(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Fw2.rawValue:
            turnF(is2Layers: true,
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
            turnL(is2Layers: true)
        case Scramble2Layers.LwPrime.rawValue:
            turnL(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Lw2.rawValue:
            turnL(is2Layers: true,
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
            turnR(is2Layers: true)
        case Scramble2Layers.RwPrime.rawValue:
            turnR(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Rw2.rawValue:
            turnR(is2Layers: true,
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
            turnD(is2Layers: true)
        case Scramble2Layers.DwPrime.rawValue:
            turnD(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Dw2.rawValue:
            turnD(is2Layers: true,
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
            turnB(is2Layers: true)
        case Scramble2Layers.BwPrime.rawValue:
            turnB(is2Layers: true,
                  isPrime: true)
        case Scramble2Layers.Bw2.rawValue:
            turnB(is2Layers: true,
                  isTwo: true)
        default:
            return
        }
        
        
    }
    
    func turnU(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnUp?.turnU(isPrime: isPrime,
                                         isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .white)
        
        if is2Layers {
            guard let result2Layer = turnUp?.turnUw(isPrime: isPrime,
                                                    isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .white)
        }
    }
    
    func turnF(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnFront?.turnF(isPrime: isPrime,
                                            isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .green)
        
        if is2Layers {
            guard let result2Layer = turnFront?.turnFw(isPrime: isPrime,
                                                       isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .green)
        }
    }
    
    func turnL(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnLeft?.turnL(isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .orange)
        
        if is2Layers {
            guard let result2Layer = turnLeft?.turnLw(isPrime: isPrime,
                                                      isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .orange)
        }
    }
    
    func turnR(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnRight?.turnR(isPrime: isPrime,
                                            isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .red)
        
        if is2Layers {
            guard let result2Layer = turnRight?.turnRw(isPrime: isPrime,
                                                       isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .red)
        }
    }
    
    func turnD(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnDown?.turnD(isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .yellow)
        
        if is2Layers {
            guard let result2Layer = turnDown?.turnDw(isPrime: isPrime,
                                                      isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .yellow)
        }
    }
    
    func turnB(is2Layers: Bool = false,
               isPrime: Bool = false,
               isTwo: Bool = false)
    {
        guard let result = turnBack?.turnB(isPrime: isPrime,
                                           isTwo: isTwo)
        else { return }
        
        reassignFace(result, face: .blue)
        
        if is2Layers {
            guard let result2Layer = turnBack?.turnBw(isPrime: isPrime,
                                                      isTwo: isTwo)
            else { return }
            
            reassignFace(result2Layer, face: .blue)
        }
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
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
