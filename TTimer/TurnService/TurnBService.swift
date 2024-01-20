//
//  TurnBService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnBInterface {
    var mainBlue: [[PieceColor]] { get }
    var white: [[PieceColor]] { get }
    var orange: [[PieceColor]] { get }
    var yellow: [[PieceColor]] { get }
    var red: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnB(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnBService: TurnBInterface {
    var mainBlue: [[PieceColor]]
    var white: [[PieceColor]]
    var orange: [[PieceColor]]
    var yellow: [[PieceColor]]
    var red: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnB(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        
        let indexCubeType = cubeType.rawValue - 1
        
        mainBlue = CubeUtils.swapIn1Face(&mainBlue,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        for index in 0...layer.rawValue {
            var result: SwapResult
            
            for indexCol in 0...2 {
                if indexCol == 0 ||
                    indexCol == 1 && CubeUtils.isBigCube(cubeType) ||
                    indexCol == 2 && CubeUtils.is6x6Or7x7Cube(cubeType) {
                    result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                            face2: &orange,
                                                            face3: &yellow,
                                                            face4: &red,
                                                            rowFace1: index,
                                                            colFace1: indexCol,
                                                            rowFace2: indexCubeType - indexCol,
                                                            colFace2: index,
                                                            rowFace3: indexCubeType - index,
                                                            colFace3: indexCubeType - indexCol,
                                                            rowFace4: indexCol,
                                                            colFace4: indexCubeType - index,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                    
                    result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                            face2: &orange,
                                                            face3: &yellow,
                                                            face4: &red,
                                                            rowFace1: index,
                                                            colFace1: indexCubeType - indexCol,
                                                            rowFace2: indexCol,
                                                            colFace2: index,
                                                            rowFace3: indexCubeType - index,
                                                            colFace3: indexCol,
                                                            rowFace4: indexCubeType - indexCol,
                                                            colFace4: indexCubeType - index,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                }
            }
            
            if CubeUtils.isOddCube(cubeType) {
                result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType / 2,
                                                        rowFace2: indexCubeType / 2,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: indexCubeType / 2,
                                                        rowFace4: indexCubeType / 2,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                reassignFace(result)
            }
        }
        
        return SwapResult(mainFace: mainBlue,
                          face1: white,
                          face2: orange,
                          face3: yellow,
                          face4: red)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let blueFace = result.mainFace {
            mainBlue = blueFace
        }
        white = result.face1
        orange = result.face2
        yellow = result.face3
        red = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType)
    {
        self.mainBlue = mainFace
        self.white = face1
        self.orange = face2
        self.yellow = face3
        self.red = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
