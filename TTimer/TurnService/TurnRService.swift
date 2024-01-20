//
//  TurnRService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnRInterface {
    var mainRed: [[PieceColor]] { get }
    var green: [[PieceColor]] { get }
    var white: [[PieceColor]] { get }
    var blue: [[PieceColor]] { get }
    var yellow: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnR(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool
    ) -> SwapResult
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnRService: TurnRInterface {
    var mainRed: [[PieceColor]]
    var green: [[PieceColor]]
    var white: [[PieceColor]]
    var blue: [[PieceColor]]
    var yellow: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnR(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainRed = CubeUtils.swapIn1Face(&mainRed,
                                        cubeType: cubeType,
                                        isPrime: isPrime,
                                        isTwo: isTwo)
        
        for indexRow in 0...layer.rawValue {
            var result: SwapResult
            
            for indexCol in 0...2 {
                if indexCol == 0 ||
                    indexCol == 1 && CubeUtils.isBigCube(cubeType) ||
                    indexCol == 2 && CubeUtils.is6x6Or7x7Cube(cubeType) {
                    result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                            face2: &white,
                                                            face3: &blue,
                                                            face4: &yellow,
                                                            rowFace1: indexCol,
                                                            colFace1: indexCubeType - indexRow,
                                                            rowFace2: indexCol,
                                                            colFace2: indexCubeType - indexRow,
                                                            rowFace3: indexCubeType - indexCol,
                                                            colFace3: indexRow,
                                                            rowFace4: indexCol,
                                                            colFace4: indexCubeType - indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                    
                    result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                            face2: &white,
                                                            face3: &blue,
                                                            face4: &yellow,
                                                            rowFace1: indexCubeType - indexCol,
                                                            colFace1: indexCubeType - indexRow,
                                                            rowFace2: indexCubeType - indexCol,
                                                            colFace2: indexCubeType - indexRow,
                                                            rowFace3: indexCol,
                                                            colFace3: indexRow,
                                                            rowFace4: indexCubeType - indexCol,
                                                            colFace4: indexCubeType - indexRow,
                                                            isPrime: isPrime,
                                                            isTwo: isTwo)
                    reassignFace(result)
                }
            }
            
            if CubeUtils.isOddCube(cubeType) {
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: indexCubeType / 2,
                                                        colFace1: indexCubeType - indexRow,
                                                        rowFace2: indexCubeType / 2,
                                                        colFace2: indexCubeType - indexRow,
                                                        rowFace3: indexCubeType / 2,
                                                        colFace3: indexRow,
                                                        rowFace4: indexCubeType / 2,
                                                        colFace4: indexCubeType - indexRow,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                reassignFace(result)
            }
        }
        
        return SwapResult(mainFace: mainRed,
                          face1: green,
                          face2: white,
                          face3: blue,
                          face4: yellow)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let redFace = result.mainFace {
            mainRed = redFace
        }
        green = result.face1
        white = result.face2
        blue = result.face3
        yellow = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType) 
    {
        self.mainRed = mainFace
        self.green = face1
        self.white = face2
        self.blue = face3
        self.yellow = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
