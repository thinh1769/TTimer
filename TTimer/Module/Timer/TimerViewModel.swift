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

class TimerViewModel {
    let bag = DisposeBag()
    var scrambleList = [String]()
    var cubeSize: CGFloat = 40
    var cubeType = CubeType.two {
        didSet {
            resetFaceColors()
            updateCubeSize()
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
    
    private func resetFaceColors() {
        white = Array(repeating: Array(repeating: .white, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
        green = Array(repeating: Array(repeating: .green, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
        yellow = Array(repeating: Array(repeating: .yellow, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
        orange = Array(repeating: Array(repeating: .orange, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
        red = Array(repeating: Array(repeating: .red, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
        blue = Array(repeating: Array(repeating: .blue, count: cubeType.rawValue + 1), count: cubeType.rawValue + 1)
    }
    
    private func updateCubeSize() {
        switch cubeType {
        case .two:
            cubeSize = PieceSize.two.rawValue * CGFloat(cubeType.rawValue + 1)
        case .three:
            cubeSize = PieceSize.three.rawValue * CGFloat(cubeType.rawValue + 1)
        case .four:
            cubeSize = PieceSize.four.rawValue * CGFloat(cubeType.rawValue + 1)
        case .five:
            cubeSize = PieceSize.five.rawValue * CGFloat(cubeType.rawValue + 1)
        case .six:
            cubeSize = PieceSize.six.rawValue * CGFloat(cubeType.rawValue + 1)
        case .seven:
            cubeSize = PieceSize.seven.rawValue * CGFloat(cubeType.rawValue + 1)
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
        switch scrambleCharacter {
        case Scramble.U.rawValue:
            turnU()
        case Scramble.UPrime.rawValue:
            turnU(isPrime: true)
        case Scramble.U2.rawValue:
            turnU(isTwo: true)
        case Scramble.F.rawValue:
            turnF()
        case Scramble.FPrime.rawValue:
            turnF(isPrime: true)
        case Scramble.F2.rawValue:
            turnF(isTwo: true)
        case Scramble.L.rawValue:
            turnL()
        case Scramble.LPrime.rawValue:
            turnL(isPrime: true)
        case Scramble.L2.rawValue:
            turnL(isTwo: true)
        case Scramble.R.rawValue:
            turnR()
        case Scramble.RPrime.rawValue:
            turnR(isPrime: true)
        case Scramble.R2.rawValue:
            turnR(isTwo: true)
        case Scramble.D.rawValue:
            turnD()
        case Scramble.DPrime.rawValue:
            turnD(isPrime: true)
        case Scramble.D2.rawValue:
            turnD(isTwo: true)
        case Scramble.B.rawValue:
            turnB()
        case Scramble.BPrime.rawValue:
            turnB(isPrime: true)
        case Scramble.B2.rawValue:
            turnB(isTwo: true)
        default:
            return
        }
    }
    
    func turnU(isPrime: Bool = false, isTwo: Bool = false) {
        ///White face
        //Corner one face
        swapFourPiecesOneFace(&white,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &green,
                               face2: &orange,
                               face3: &blue,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: 0,
                               rowFace2: 0,
                               colFace2: 0,
                               rowFace3: 0,
                               colFace3: 0,
                               rowFace4: 0,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &green,
                               face2: &orange,
                               face3: &blue,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: cubeType.rawValue,
                               rowFace2: 0,
                               colFace2: cubeType.rawValue,
                               rowFace3: 0,
                               colFace3: cubeType.rawValue,
                               rowFace4: 0,
                               colFace4: cubeType.rawValue,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&white,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge multi face
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue / 2,
                                    rowFace2: 0,
                                    colFace2: cubeType.rawValue / 2,
                                    rowFace3: 0,
                                    colFace3: cubeType.rawValue / 2,
                                    rowFace4: 0,
                                    colFace4: cubeType.rawValue / 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&white,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge one face
            swapFourPiecesOneFace(&white,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge onde face
            swapFourPiecesOneFace(&white,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge multi face
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 1,
                                    rowFace2: 0,
                                    colFace2: 1,
                                    rowFace3: 0,
                                    colFace3: 1,
                                    rowFace4: 0,
                                    colFace4: 1,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 1,
                                    rowFace2: 0,
                                    colFace2: cubeType.rawValue - 1,
                                    rowFace3: 0,
                                    colFace3: cubeType.rawValue - 1,
                                    rowFace4: 0,
                                    colFace4: cubeType.rawValue - 1,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&white,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //2rd piece right of the edge
            swapFourPiecesOneFace(&white,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 2,
                                    rowFace2: 0,
                                    colFace2: 2,
                                    rowFace3: 0,
                                    colFace3: 2,
                                    rowFace4: 0,
                                    colFace4: 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
            
            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 2,
                                    rowFace2: 0,
                                    colFace2: cubeType.rawValue - 2,
                                    rowFace3: 0,
                                    colFace3: cubeType.rawValue - 2,
                                    rowFace4: 0,
                                    colFace4: cubeType.rawValue - 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnUw(isPrime: Bool = false, isTwo: Bool = false) {
        turnU(isPrime: isPrime, isTwo: isTwo)
        
        //Left Edge
        swapFourPiecesMultiFace(face1: &green,
                                face2: &orange,
                                face3: &blue,
                                face4: &red,
                                rowFace1: 1,
                                colFace1: 0,
                                rowFace2: 1,
                                colFace2: 0,
                                rowFace3: 1,
                                colFace3: 0,
                                rowFace4: 1,
                                colFace4: 0,
                                isPrime: isPrime,
                                isTwo: isTwo)
        
        //Right Edge
        swapFourPiecesMultiFace(face1: &green,
                                face2: &orange,
                                face3: &blue,
                                face4: &red,
                                rowFace1: 1,
                                colFace1: cubeType.rawValue,
                                rowFace2: 1,
                                colFace2: cubeType.rawValue,
                                rowFace3: 1,
                                colFace3: cubeType.rawValue,
                                rowFace4: 1,
                                colFace4: cubeType.rawValue,
                                isPrime: isPrime,
                                isTwo: isTwo)
        
        //Left corner center
        swapFourPiecesMultiFace(face1: &green,
                                face2: &orange,
                                face3: &blue,
                                face4: &red,
                                rowFace1: 1,
                                colFace1: 1,
                                rowFace2: 1,
                                colFace2: 1,
                                rowFace3: 1,
                                colFace3: 1,
                                rowFace4: 1,
                                colFace4: 1,
                                isPrime: isPrime,
                                isTwo: isTwo)
        
        //Right corner center
        swapFourPiecesMultiFace(face1: &green,
                                face2: &orange,
                                face3: &blue,
                                face4: &red,
                                rowFace1: 1,
                                colFace1: cubeType.rawValue - 1,
                                rowFace2: 1,
                                colFace2: cubeType.rawValue - 1,
                                rowFace3: 1,
                                colFace3: cubeType.rawValue - 1,
                                rowFace4: 1,
                                colFace4: cubeType.rawValue - 1,
                                isPrime: isPrime,
                                isTwo: isTwo)
        
        //Center of the center
        if cubeType == .five || cubeType == .seven {
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 1,
                                    colFace1: cubeType.rawValue / 2,
                                    rowFace2: 1,
                                    colFace2: cubeType.rawValue / 2,
                                    rowFace3: 1,
                                    colFace3: cubeType.rawValue / 2,
                                    rowFace4: 1,
                                    colFace4: cubeType.rawValue / 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
            
        }
        
        if cubeType == .six || cubeType == .seven {
            //Left center of the center
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 1,
                                    colFace1: 2,
                                    rowFace2: 1,
                                    colFace2: 2,
                                    rowFace3: 1,
                                    colFace3: 2,
                                    rowFace4: 1,
                                    colFace4: 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
            
            //Right center of the center
            swapFourPiecesMultiFace(face1: &green,
                                    face2: &orange,
                                    face3: &blue,
                                    face4: &red,
                                    rowFace1: 1,
                                    colFace1: cubeType.rawValue - 2,
                                    rowFace2: 1,
                                    colFace2: cubeType.rawValue - 2,
                                    rowFace3: 1,
                                    colFace3: cubeType.rawValue - 2,
                                    rowFace4: 1,
                                    colFace4: cubeType.rawValue - 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnF(isPrime: Bool = false, isTwo: Bool = false) {
        ///Green face
        //Corner one face
        swapFourPiecesOneFace(&green,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &orange,
                               face3: &white,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: 0,
                               rowFace2: 0,
                               colFace2: cubeType.rawValue,
                               rowFace3: cubeType.rawValue,
                               colFace3: cubeType.rawValue,
                               rowFace4: cubeType.rawValue,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &orange,
                               face3: &white,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: cubeType.rawValue,
                               rowFace2: cubeType.rawValue,
                               colFace2: cubeType.rawValue,
                               rowFace3: cubeType.rawValue,
                               colFace3: 0,
                               rowFace4: 0,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&green,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &orange,
                                    face3: &white,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue / 2,
                                    rowFace2: cubeType.rawValue / 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue / 2,
                                    rowFace4: cubeType.rawValue / 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&green,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge one face
            swapFourPiecesOneFace(&green,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesOneFace(&green,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //Left edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &orange,
                                    face3: &white,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 1,
                                    rowFace2: 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 1,
                                    rowFace4: cubeType.rawValue - 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
            
            //Right edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &orange,
                                    face3: &white,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 1,
                                    rowFace2: cubeType.rawValue - 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 1,
                                    rowFace4: 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }

        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&green,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece right of the edge
            swapFourPiecesOneFace(&green,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &orange,
                                    face3: &white,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 2,
                                    rowFace2: 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 2,
                                    rowFace4: cubeType.rawValue - 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &orange,
                                    face3: &white,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 2,
                                    rowFace2: cubeType.rawValue - 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 2,
                                    rowFace4: 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnL(isPrime: Bool = false, isTwo: Bool = false) {
        ///Orange face
        //Corner one face
        swapFourPiecesOneFace(&orange,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &blue,
                               face3: &white,
                               face4: &green,
                               rowFace1: cubeType.rawValue,
                               colFace1: 0,
                               rowFace2: 0,
                               colFace2: cubeType.rawValue,
                               rowFace3: cubeType.rawValue,
                               colFace3: 0,
                               rowFace4: cubeType.rawValue,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &blue,
                               face3: &white,
                               face4: &green,
                               rowFace1: 0,
                               colFace1: 0,
                               rowFace2: cubeType.rawValue,
                               colFace2: cubeType.rawValue,
                               rowFace3: 0,
                               colFace3: 0,
                               rowFace4: 0,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&orange,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge of multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &blue,
                                    face3: &white,
                                    face4: &green,
                                    rowFace1: cubeType.rawValue / 2,
                                    colFace1: 0,
                                    rowFace2: cubeType.rawValue / 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue / 2,
                                    colFace3: 0,
                                    rowFace4: cubeType.rawValue / 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&orange,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            //Left edge one face
            swapFourPiecesOneFace(&orange,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesOneFace(&orange,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //Left edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &blue,
                                    face3: &white,
                                    face4: &green,
                                    rowFace1: cubeType.rawValue - 1,
                                    colFace1: 0,
                                    rowFace2: 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue - 1,
                                    colFace3: 0,
                                    rowFace4: cubeType.rawValue - 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //Right edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &blue,
                                    face3: &white,
                                    face4: &green,
                                    rowFace1: 1,
                                    colFace1: 0,
                                    rowFace2: cubeType.rawValue - 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: 1,
                                    colFace3: 0,
                                    rowFace4: 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }

        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&orange,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece right of the edge
            swapFourPiecesOneFace(&orange,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &blue,
                                    face3: &white,
                                    face4: &green,
                                    rowFace1: cubeType.rawValue - 2,
                                    colFace1: 0,
                                    rowFace2: 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue - 2,
                                    colFace3: 0,
                                    rowFace4: cubeType.rawValue - 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &blue,
                                    face3: &white,
                                    face4: &green,
                                    rowFace1: 2,
                                    colFace1: 0,
                                    rowFace2: cubeType.rawValue - 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: 2,
                                    colFace3: 0,
                                    rowFace4: 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnR(isPrime: Bool = false, isTwo: Bool = false) {
        /// Orange face
        //Corner one face
        swapFourPiecesOneFace(&red,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &green,
                               face3: &white,
                               face4: &blue,
                               rowFace1: 0,
                               colFace1: cubeType.rawValue,
                               rowFace2: 0,
                               colFace2: cubeType.rawValue,
                               rowFace3: 0,
                               colFace3: cubeType.rawValue,
                               rowFace4: cubeType.rawValue,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &yellow,
                               face2: &green,
                               face3: &white,
                               face4: &blue,
                               rowFace1: cubeType.rawValue,
                               colFace1: cubeType.rawValue,
                               rowFace2: cubeType.rawValue,
                               colFace2: cubeType.rawValue,
                               rowFace3: cubeType.rawValue,
                               colFace3: cubeType.rawValue,
                               rowFace4: 0,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&red,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &green,
                                    face3: &white,
                                    face4: &blue,
                                    rowFace1: cubeType.rawValue / 2,
                                    colFace1: cubeType.rawValue,
                                    rowFace2: cubeType.rawValue / 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue / 2,
                                    colFace3: cubeType.rawValue,
                                    rowFace4: cubeType.rawValue / 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&red,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge one face
            swapFourPiecesOneFace(&red,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesOneFace(&red,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //Left edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &green,
                                    face3: &white,
                                    face4: &blue,
                                    rowFace1: 1,
                                    colFace1: cubeType.rawValue,
                                    rowFace2: 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: 1,
                                    colFace3: cubeType.rawValue,
                                    rowFace4: cubeType.rawValue - 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //Right edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &green,
                                    face3: &white,
                                    face4: &blue,
                                    rowFace1: cubeType.rawValue - 1,
                                    colFace1: cubeType.rawValue,
                                    rowFace2: cubeType.rawValue - 1,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue - 1,
                                    colFace3: cubeType.rawValue,
                                    rowFace4: 1,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }

        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&red,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece right of the edge
            swapFourPiecesOneFace(&red,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &green,
                                    face3: &white,
                                    face4: &blue,
                                    rowFace1: 2,
                                    colFace1: cubeType.rawValue,
                                    rowFace2: 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: 2,
                                    colFace3: cubeType.rawValue,
                                    rowFace4: cubeType.rawValue - 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &yellow,
                                    face2: &green,
                                    face3: &white,
                                    face4: &blue,
                                    rowFace1: cubeType.rawValue - 2,
                                    colFace1: cubeType.rawValue,
                                    rowFace2: cubeType.rawValue - 2,
                                    colFace2: cubeType.rawValue,
                                    rowFace3: cubeType.rawValue - 2,
                                    colFace3: cubeType.rawValue,
                                    rowFace4: 2,
                                    colFace4: 0,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnD(isPrime: Bool = false, isTwo: Bool = false) {
        /// Yellow face
        //Corner one face
        swapFourPiecesOneFace(&yellow,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &blue,
                               face2: &orange,
                               face3: &green,
                               face4: &red,
                               rowFace1: cubeType.rawValue,
                               colFace1: cubeType.rawValue,
                               rowFace2: cubeType.rawValue,
                               colFace2: cubeType.rawValue,
                               rowFace3: cubeType.rawValue,
                               colFace3: cubeType.rawValue,
                               rowFace4: cubeType.rawValue,
                               colFace4: cubeType.rawValue,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &blue,
                               face2: &orange,
                               face3: &green,
                               face4: &red,
                               rowFace1: cubeType.rawValue,
                               colFace1: 0,
                               rowFace2: cubeType.rawValue,
                               colFace2: 0,
                               rowFace3: cubeType.rawValue,
                               colFace3: 0,
                               rowFace4: cubeType.rawValue,
                               colFace4: 0,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&yellow,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge multi face
            swapFourPiecesMultiFace(face1: &blue,
                                    face2: &orange,
                                    face3: &green,
                                    face4: &red,
                                    rowFace1: cubeType.rawValue,
                                    colFace1: cubeType.rawValue / 2,
                                    rowFace2: cubeType.rawValue,
                                    colFace2: cubeType.rawValue / 2,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue / 2,
                                    rowFace4: cubeType.rawValue,
                                    colFace4: cubeType.rawValue / 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&yellow,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge one face
            swapFourPiecesOneFace(&yellow,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesOneFace(&yellow,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //Left edge multi face
            swapFourPiecesMultiFace(face1: &blue,
                                    face2: &orange,
                                    face3: &green,
                                    face4: &red,
                                    rowFace1: cubeType.rawValue,
                                    colFace1: cubeType.rawValue - 1,
                                    rowFace2: cubeType.rawValue,
                                    colFace2: cubeType.rawValue - 1,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 1,
                                    rowFace4: cubeType.rawValue,
                                    colFace4: cubeType.rawValue - 1,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //Right edge multi face
            swapFourPiecesMultiFace(face1: &blue,
                                    face2: &orange,
                                    face3: &green,
                                    face4: &red,
                                    rowFace1: cubeType.rawValue,
                                    colFace1: 1,
                                    rowFace2: cubeType.rawValue,
                                    colFace2: 1,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 1,
                                    rowFace4: cubeType.rawValue,
                                    colFace4: 1,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }

        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&yellow,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece right of the edge
            swapFourPiecesOneFace(&yellow,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &blue,
                                    face2: &orange,
                                    face3: &green,
                                    face4: &red,
                                    rowFace1: cubeType.rawValue,
                                    colFace1: cubeType.rawValue - 2,
                                    rowFace2: cubeType.rawValue,
                                    colFace2: cubeType.rawValue - 2,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 2,
                                    rowFace4: cubeType.rawValue,
                                    colFace4: cubeType.rawValue - 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &blue,
                                    face2: &orange,
                                    face3: &green,
                                    face4: &red,
                                    rowFace1: cubeType.rawValue,
                                    colFace1: 2,
                                    rowFace2: cubeType.rawValue,
                                    colFace2: 2,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 2,
                                    rowFace4: cubeType.rawValue,
                                    colFace4: 2,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func turnB(isPrime: Bool = false, isTwo: Bool = false) {
        /// Blue face
        //Corner one face
        swapFourPiecesOneFace(&blue,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType.rawValue,
                             row3: cubeType.rawValue,
                             col3: cubeType.rawValue,
                             row4: cubeType.rawValue,
                             col4: 0,
                             isPrime: isPrime,
                             isTwo: isTwo)
        
        //Left corner multi face
        swapFourPiecesMultiFace(face1: &white,
                               face2: &orange,
                               face3: &yellow,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: 0,
                               rowFace2: cubeType.rawValue,
                               colFace2: 0,
                               rowFace3: cubeType.rawValue,
                               colFace3: cubeType.rawValue,
                               rowFace4: 0,
                               colFace4: cubeType.rawValue,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        //Right corner multi face
        swapFourPiecesMultiFace(face1: &white,
                               face2: &orange,
                               face3: &yellow,
                               face4: &red,
                               rowFace1: 0,
                               colFace1: cubeType.rawValue,
                               rowFace2: 0,
                               colFace2: 0,
                               rowFace3: cubeType.rawValue,
                               colFace3: 0,
                               rowFace4: cubeType.rawValue,
                               colFace4: cubeType.rawValue,
                               isPrime: isPrime,
                               isTwo: isTwo)
        
        if cubeType == .three || cubeType == .five || cubeType == .seven {
            //Center edge one face
            swapFourPiecesOneFace(&blue,
                                  row1: 0,
                                  col1: cubeType.rawValue / 2,
                                  row2: cubeType.rawValue / 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue / 2,
                                  row4: cubeType.rawValue / 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Center edge multi face
            swapFourPiecesMultiFace(face1: &white,
                                    face2: &orange,
                                    face3: &yellow,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue / 2,
                                    rowFace2: cubeType.rawValue / 2,
                                    colFace2: 0,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue / 2,
                                    rowFace4: cubeType.rawValue / 2,
                                    colFace4: cubeType.rawValue,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
        
        if cubeType != .two && cubeType != .three {
            //Corner of center one face
            swapFourPiecesOneFace(&blue,
                                  row1: 1,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue - 1,
                                  row3: cubeType.rawValue - 1,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 1,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Left edge one face
            swapFourPiecesOneFace(&blue,
                                  row1: 0,
                                  col1: 1,
                                  row2: 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 1,
                                  row4: cubeType.rawValue - 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)
            
            //Right edge one face
            swapFourPiecesOneFace(&blue,
                                  row1: 0,
                                  col1: cubeType.rawValue - 1,
                                  row2: cubeType.rawValue - 1,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 1,
                                  row4: 1,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //Left edge multi face
            swapFourPiecesMultiFace(face1: &white,
                                    face2: &orange,
                                    face3: &yellow,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 1,
                                    rowFace2: cubeType.rawValue - 1,
                                    colFace2: 0,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 1,
                                    rowFace4: 1,
                                    colFace4: cubeType.rawValue,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //Right edge multi face
            swapFourPiecesMultiFace(face1: &white,
                                    face2: &orange,
                                    face3: &yellow,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 1,
                                    rowFace2: 1,
                                    colFace2: 0,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 1,
                                    rowFace4: cubeType.rawValue - 1,
                                    colFace4: cubeType.rawValue,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }

        if cubeType == .six || cubeType == .seven {
            //2rd piece left of the edge
            swapFourPiecesOneFace(&blue,
                                  row1: 0,
                                  col1: 2,
                                  row2: 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: cubeType.rawValue - 2,
                                  row4: cubeType.rawValue - 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece right of the edge
            swapFourPiecesOneFace(&blue,
                                  row1: 0,
                                  col1: cubeType.rawValue - 2,
                                  row2: cubeType.rawValue - 2,
                                  col2: cubeType.rawValue,
                                  row3: cubeType.rawValue,
                                  col3: 2,
                                  row4: 2,
                                  col4: 0,
                                  isPrime: isPrime,
                                  isTwo: isTwo)

            //2rd piece left of the edge multi face
            swapFourPiecesMultiFace(face1: &white,
                                    face2: &orange,
                                    face3: &yellow,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: 2,
                                    rowFace2: cubeType.rawValue - 2,
                                    colFace2: 0,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: cubeType.rawValue - 2,
                                    rowFace4: 2,
                                    colFace4: cubeType.rawValue,
                                    isPrime: isPrime,
                                    isTwo: isTwo)

            //2rd piece right of the edge multi face
            swapFourPiecesMultiFace(face1: &white,
                                    face2: &orange,
                                    face3: &yellow,
                                    face4: &red,
                                    rowFace1: 0,
                                    colFace1: cubeType.rawValue - 2,
                                    rowFace2: 2,
                                    colFace2: 0,
                                    rowFace3: cubeType.rawValue,
                                    colFace3: 2,
                                    rowFace4: cubeType.rawValue - 2,
                                    colFace4: cubeType.rawValue,
                                    isPrime: isPrime,
                                    isTwo: isTwo)
        }
    }
    
    func swapFourPiecesOneFace(_ face: inout [[PieceColor]],
                              row1: Int,
                              col1: Int,
                              row2: Int,
                              col2: Int,
                              row3: Int,
                              col3: Int,
                              row4: Int,
                              col4: Int,
                              isPrime: Bool,
                              isTwo: Bool
    ) {
        let cell1 = face[row1][col1]
        let cell2 = face[row2][col2]
        let cell3 = face[row3][col3]
        let cell4 = face[row4][col4]
        
        if isPrime {
            face[row4][col4] = cell1
            face[row1][col1] = cell2
            face[row2][col2] = cell3
            face[row3][col3] = cell4
        } else if isTwo {
            face[row4][col4] = cell2
            face[row1][col1] = cell3
            face[row2][col2] = cell4
            face[row3][col3] = cell1
        } else {
            face[row1][col1] = cell4
            face[row2][col2] = cell1
            face[row3][col3] = cell2
            face[row4][col4] = cell3
        }
    }
    
    func swapFourPiecesMultiFace(face1: inout [[PieceColor]],
                                face2: inout [[PieceColor]],
                                face3: inout [[PieceColor]],
                                face4: inout [[PieceColor]],
                                rowFace1: Int,
                                colFace1: Int,
                                rowFace2: Int,
                                colFace2: Int,
                                rowFace3: Int,
                                colFace3: Int,
                                rowFace4: Int,
                                colFace4: Int,
                                isPrime: Bool,
                                isTwo: Bool
    ) {
        let cell1 = face1[rowFace1][colFace1]
        let cell2 = face2[rowFace2][colFace2]
        let cell3 = face3[rowFace3][colFace3]
        let cell4 = face4[rowFace4][colFace4]
        
        if isPrime {
            face1[rowFace1][colFace1] = cell2
            face2[rowFace2][colFace2] = cell3
            face3[rowFace3][colFace3] = cell4
            face4[rowFace4][colFace4] = cell1
        } else if isTwo {
            face1[rowFace1][colFace1] = cell3
            face2[rowFace2][colFace2] = cell4
            face3[rowFace3][colFace3] = cell1
            face4[rowFace4][colFace4] = cell2
        } else {
            face1[rowFace1][colFace1] = cell4
            face2[rowFace2][colFace2] = cell1
            face3[rowFace3][colFace3] = cell2
            face4[rowFace4][colFace4] = cell3
        }
    }
}
