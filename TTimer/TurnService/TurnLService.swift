//
//  TurnLService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnLInterface {
    var mainOrange: [[PieceColor]] { get }
    var yellow: [[PieceColor]] { get }
    var blue: [[PieceColor]] { get }
    var white: [[PieceColor]] { get }
    var green: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnL(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnLService: TurnLInterface {
    var mainOrange: [[PieceColor]]
    var yellow: [[PieceColor]]
    var blue: [[PieceColor]]
    var white: [[PieceColor]]
    var green: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnL(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainOrange = CubeUtils.swapIn1Face(&mainOrange,
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
                                                            face2: &blue,
                                                            face3: &white,
                                                            face4: &green,
                                                            rowFace1: indexCubeType - indexCol,
                                                            colFace1: indexRow,
                                                            rowFace2: indexCubeType - indexCol,
                                                            colFace2: indexRow,
                                                            rowFace3: indexCol,
                                                            colFace3: indexCubeType - indexRow,
                                                            rowFace4: indexCubeType - indexCol,
                                                            colFace4: indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                    
                    result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                            face2: &blue,
                                                            face3: &white,
                                                            face4: &green,
                                                            rowFace1: indexCol,
                                                            colFace1: indexRow,
                                                            rowFace2: indexCol,
                                                            colFace2: indexRow,
                                                            rowFace3: indexCubeType - indexCol,
                                                            colFace3: indexCubeType - indexRow,
                                                            rowFace4: indexCol,
                                                            colFace4: indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                }
            }
            
            if CubeUtils.isOddCube(cubeType) {
                result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                        face2: &blue,
                                                        face3: &white,
                                                        face4: &green,
                                                        rowFace1: indexCubeType / 2,
                                                        colFace1: indexRow,
                                                        rowFace2: indexCubeType / 2,
                                                        colFace2: indexRow,
                                                        rowFace3: indexCubeType / 2,
                                                        colFace3: indexCubeType - indexRow,
                                                        rowFace4: indexCubeType / 2,
                                                        colFace4: indexRow,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                reassignFace(result)
            }
        }
        
        return SwapResult(mainFace: mainOrange,
                          face1: yellow,
                          face2: blue,
                          face3: white,
                          face4: green)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let orangeFace = result.mainFace {
            mainOrange = orangeFace
        }
        yellow = result.face1
        blue = result.face2
        white = result.face3
        green = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType)
    {
        self.mainOrange = mainFace
        self.yellow = face1
        self.blue = face2
        self.white = face3
        self.green = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
