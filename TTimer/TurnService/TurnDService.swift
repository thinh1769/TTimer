//
//  TurnDService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnDInterface {
    var mainYellow: [[PieceColor]] { get }
    var blue: [[PieceColor]] { get }
    var orange: [[PieceColor]] { get }
    var green: [[PieceColor]] { get }
    var red: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnD(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnDService: TurnDInterface {
    var mainYellow: [[PieceColor]]
    var blue: [[PieceColor]]
    var orange: [[PieceColor]]
    var green: [[PieceColor]]
    var red: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnD(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainYellow = CubeUtils.swapIn1Face(&mainYellow,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        for indexRow in 0...layer.rawValue {
            var result: SwapResult
            
            for indexCol in 0...2 {
                if indexCol == 0 ||
                    indexCol == 1 && CubeUtils.isBigCube(cubeType) ||
                    indexCol == 2 && CubeUtils.is6x6Or7x7Cube(cubeType) {
                    result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                            face2: &orange,
                                                            face3: &green,
                                                            face4: &red,
                                                            rowFace1: indexCubeType - indexRow,
                                                            colFace1: indexCubeType - indexCol,
                                                            rowFace2: indexCubeType - indexRow,
                                                            colFace2: indexCubeType - indexCol,
                                                            rowFace3: indexCubeType - indexRow,
                                                            colFace3: indexCubeType - indexCol,
                                                            rowFace4: indexCubeType - indexRow,
                                                            colFace4: indexCubeType - indexCol,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                    
                    result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                            face2: &orange,
                                                            face3: &green,
                                                            face4: &red,
                                                            rowFace1: indexCubeType - indexRow,
                                                            colFace1: indexCol,
                                                            rowFace2: indexCubeType - indexRow,
                                                            colFace2: indexCol,
                                                            rowFace3: indexCubeType - indexRow,
                                                            colFace3: indexCol,
                                                            rowFace4: indexCubeType - indexRow,
                                                            colFace4: indexCol,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                }
            }
            
            if CubeUtils.isOddCube(cubeType) {
                result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                        face2: &orange,
                                                        face3: &green,
                                                        face4: &red,
                                                        rowFace1: indexCubeType - indexRow,
                                                        colFace1: indexCubeType / 2,
                                                        rowFace2: indexCubeType - indexRow,
                                                        colFace2: indexCubeType / 2,
                                                        rowFace3: indexCubeType - indexRow,
                                                        colFace3: indexCubeType / 2,
                                                        rowFace4: indexCubeType - indexRow,
                                                        colFace4: indexCubeType / 2,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                reassignFace(result)
            }
        }
        
        return SwapResult(mainFace: mainYellow,
                          face1: blue,
                          face2: orange,
                          face3: green,
                          face4: red)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let yellowFace = result.mainFace {
            mainYellow = yellowFace
        }
        blue = result.face1
        orange = result.face2
        green = result.face3
        red = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType)
    {
        self.mainYellow = mainFace
        self.blue = face1
        self.orange = face2
        self.green = face3
        self.red = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
