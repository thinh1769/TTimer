//
//  TurnFService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 12/01/2024.
//

import Foundation
import SwiftUI

protocol TurnFInterface {
    var mainGreen: [[PieceColor]] { get }
    var yellow: [[PieceColor]] { get }
    var orange: [[PieceColor]] { get }
    var white: [[PieceColor]] { get }
    var red: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnF(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnFService: TurnFInterface {
    var mainGreen: [[PieceColor]]
    var yellow: [[PieceColor]]
    var orange: [[PieceColor]]
    var white: [[PieceColor]]
    var red: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnF(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainGreen = CubeUtils.swapIn1Face(&mainGreen,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        for indexRow in 0...layer.rawValue {
            var result: SwapResult
            
            for indexCol in 0...2 {
                if indexCol == 0 ||
                    indexCol == 1 && CubeUtils.isBigCube(cubeType) ||
                    indexCol == 2 && CubeUtils.is6x6Or7x7Cube(cubeType) {
                    result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                            face2: &orange,
                                                            face3: &white,
                                                            face4: &red,
                                                            rowFace1: indexRow,
                                                            colFace1: indexCol,
                                                            rowFace2: indexCol,
                                                            colFace2: indexCubeType - indexRow,
                                                            rowFace3: indexCubeType - indexRow,
                                                            colFace3: indexCubeType - indexCol,
                                                            rowFace4: indexCubeType - indexCol,
                                                            colFace4: indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                    
                    result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                            face2: &orange,
                                                            face3: &white,
                                                            face4: &red,
                                                            rowFace1: indexRow,
                                                            colFace1: indexCubeType - indexCol,
                                                            rowFace2: indexCubeType - indexCol,
                                                            colFace2: indexCubeType - indexRow,
                                                            rowFace3: indexCubeType - indexRow,
                                                            colFace3: indexCol,
                                                            rowFace4: indexCol,
                                                            colFace4: indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                }
            }
            
            if CubeUtils.isOddCube(cubeType) {
                result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                        face2: &orange,
                                                        face3: &white,
                                                        face4: &red,
                                                        rowFace1: indexRow,
                                                        colFace1: indexCubeType / 2,
                                                        rowFace2: indexCubeType / 2,
                                                        colFace2: indexCubeType - indexRow,
                                                        rowFace3: indexCubeType - indexRow,
                                                        colFace3: indexCubeType / 2,
                                                        rowFace4: indexCubeType / 2,
                                                        colFace4: indexRow,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
        }
        
        return SwapResult(mainFace: mainGreen,
                          face1: yellow,
                          face2: orange,
                          face3: white,
                          face4: red)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let greenFace = result.mainFace {
            mainGreen = greenFace
        }
        yellow = result.face1
        orange = result.face2
        white = result.face3
        red = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType)
    {
        self.mainGreen = mainFace
        self.yellow = face1
        self.orange = face2
        self.white = face3
        self.red = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
