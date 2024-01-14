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
        
        for index in 0...layer.rawValue {
            mainRed = CubeUtils.swapIn1Face(&mainRed,
                                            cubeType: cubeType,
                                            isPrime: isPrime,
                                            isTwo: isTwo)
            
            //Left corner multi face
            var result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: 0,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: 0,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: indexCubeType,
                                                        colFace3: index,
                                                        rowFace4: 0,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
            
            reassignFace(result)
            
            //Right corner multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                    face2: &white,
                                                    face3: &blue,
                                                    face4: &yellow,
                                                    rowFace1: indexCubeType,
                                                    colFace1: indexCubeType - index,
                                                    rowFace2: indexCubeType,
                                                    colFace2: indexCubeType - index,
                                                    rowFace3: 0,
                                                    colFace3: index,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType - index,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            if CubeUtils.isOddCube(cubeType) {
                //Center edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: indexCubeType / 2,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: indexCubeType / 2,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: indexCubeType / 2,
                                                        colFace3: index,
                                                        rowFace4: indexCubeType / 2,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
            
            if CubeUtils.isBigCube(cubeType) {
                //Left edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: 1,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: 1,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: indexCubeType - 1,
                                                        colFace3: index,
                                                        rowFace4: 1,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //Right edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: indexCubeType - 1,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: indexCubeType - 1,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: 1,
                                                        colFace3: index,
                                                        rowFace4: indexCubeType - 1,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
            
            if CubeUtils.is6x6Or7x7Cube(cubeType) {
                //2nd piece left of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: 2,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: 2,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: indexCubeType - 2,
                                                        colFace3: index,
                                                        rowFace4: 2,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //2nd piece right of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &white,
                                                        face3: &blue,
                                                        face4: &yellow,
                                                        rowFace1: indexCubeType - 2,
                                                        colFace1: indexCubeType - index,
                                                        rowFace2: indexCubeType - 2,
                                                        colFace2: indexCubeType - index,
                                                        rowFace3: 2,
                                                        colFace3: index,
                                                        rowFace4: indexCubeType - 2,
                                                        colFace4: indexCubeType - index,
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
