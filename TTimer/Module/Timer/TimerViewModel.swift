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
    let bag = DisposeBag()
    var scrambleList: [String]
    var cubeSize: CGFloat
    var indexCubeType: Int
    var cubeType: CubeType {
        didSet {
            resetFaceColors()
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
    
    let whiteData = BehaviorRelay<[PieceColor]>(value: [])
    let greenData = BehaviorRelay<[PieceColor]>(value: [])
    let yellowData = BehaviorRelay<[PieceColor]>(value: [])
    let orangeData = BehaviorRelay<[PieceColor]>(value: [])
    let redData = BehaviorRelay<[PieceColor]>(value: [])
    let blueData = BehaviorRelay<[PieceColor]>(value: [])
    
    var white: [[PieceColor]] = Array(repeating: Array(repeating: .white, count: 3), count: 3)
    var green: [[PieceColor]] = Array(repeating: Array(repeating: .green, count: 3), count: 3)
    var yellow: [[PieceColor]] = Array(repeating: Array(repeating: .yellow, count: 3), count: 3)
    var orange: [[PieceColor]] = Array(repeating: Array(repeating: .orange, count: 3), count: 3)
    var red: [[PieceColor]] = Array(repeating: Array(repeating: .red, count: 3), count: 3)
    var blue: [[PieceColor]] = Array(repeating: Array(repeating: .blue, count: 3), count: 3)
    
    var turnUp: TurnUService?
    var turnFront: TurnFService?
    var turnLeft: TurnLService?
    var turnRight: TurnRService?
    var turnDown: TurnDService?
    var turnBack: TurnBService?
    
    init(scrambleList: [String] = [""],
         cubeSize: CGFloat = 40,
         cubeType: CubeType = CubeType.two,
         indexCubeType: Int = 0,
         white: [[PieceColor]] = [[]],
         green: [[PieceColor]] = [[]],
         yellow: [[PieceColor]] = [[]],
         orange: [[PieceColor]] = [[]],
         red: [[PieceColor]] = [[]],
         blue: [[PieceColor]] = [[]])
    {
        self.scrambleList = scrambleList
        self.cubeSize = cubeSize
        self.cubeType = cubeType
        self.indexCubeType = indexCubeType
        self.white = white
        self.green = green
        self.yellow = yellow
        self.orange = orange
        self.red = red
        self.blue = blue
    }
    
    private func resetFaceColors() {
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
        resetFaceColors()
        
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
        //        switch scrambleCharacter {
        //        case Scramble.U.rawValue:
        //            turnU()
        //        case Scramble.UPrime.rawValue:
        //            turnU(isPrime: true)
        //        case Scramble.U2.rawValue:
        //            turnU(isTwo: true)
        //        case Scramble.F.rawValue:
        //            turnF()
        //        case Scramble.FPrime.rawValue:
        //            turnF(isPrime: true)
        //        case Scramble.F2.rawValue:
        //            turnF(isTwo: true)
        //        case Scramble.L.rawValue:
        //            turnL()
        //        case Scramble.LPrime.rawValue:
        //            turnL(isPrime: true)
        //        case Scramble.L2.rawValue:
        //            turnL(isTwo: true)
        //        case Scramble.R.rawValue:
        //            turnR()
        //        case Scramble.RPrime.rawValue:
        //            turnR(isPrime: true)
        //        case Scramble.R2.rawValue:
        //            turnR(isTwo: true)
        //        case Scramble.D.rawValue:
        //            turnD()
        //        case Scramble.DPrime.rawValue:
        //            turnD(isPrime: true)
        //        case Scramble.D2.rawValue:
        //            turnD(isTwo: true)
        //        case Scramble.B.rawValue:
        //            turnB()
        //        case Scramble.BPrime.rawValue:
        //            turnB(isPrime: true)
        //        case Scramble.B2.rawValue:
        //            turnB(isTwo: true)
        //        default:
        //            return
        //        }
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
            green = result.face1
            orange = result.face2
            blue = result.face3
            red = result.face4
            
        case .green:
            yellow = result.face1
            orange = result.face2
            white = result.face3
            red = result.face4
            
        case .yellow:
            blue = result.face1
            orange = result.face2
            green = result.face3
            red = result.face4
            
        case .orange:
            green = result.face1
            yellow = result.face2
            blue = result.face3
            white = result.face4
            
        case .red:
            green = result.face1
            white = result.face2
            blue = result.face3
            yellow = result.face4
            
        case .blue:
            white = result.face1
            orange = result.face2
            yellow = result.face3
            red = result.face4
        }
        
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
