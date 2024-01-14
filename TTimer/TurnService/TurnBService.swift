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
            //Left corner multi face
            var result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 0,
                                                        rowFace2: indexCubeType,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: indexCubeType,
                                                        rowFace4: 0,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
            
            reassignFace(result)
            
            //Right corner multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                    face2: &orange,
                                                    face3: &yellow,
                                                    face4: &red,
                                                    rowFace1: index,
                                                    colFace1: indexCubeType,
                                                    rowFace2: 0,
                                                    colFace2: index,
                                                    rowFace3: indexCubeType - index,
                                                    colFace3: 0,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType - index,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            if CubeUtils.isOddCube(cubeType) {
                //Center edge multi face
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
            
            if CubeUtils.isBigCube(cubeType) {
                //Left edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 1,
                                                        rowFace2: indexCubeType - 1,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: indexCubeType - 1,
                                                        rowFace4: 1,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //Right edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType - 1,
                                                        rowFace2: 1,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: 1,
                                                        rowFace4: indexCubeType - 1,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
            
            if CubeUtils.is6x6Or7x7Cube(cubeType) {
                //2nd piece left of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 2,
                                                        rowFace2: indexCubeType - 2,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: indexCubeType - 2,
                                                        rowFace4: 2,
                                                        colFace4: indexCubeType - index,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //2nd piece right of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                        face2: &orange,
                                                        face3: &yellow,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType - 2,
                                                        rowFace2: 2,
                                                        colFace2: index,
                                                        rowFace3: indexCubeType - index,
                                                        colFace3: 2,
                                                        rowFace4: indexCubeType - 2,
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
    
    mutating func turnBw(isPrime: Bool,
                         isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        //Left Edge
        var result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                    face2: &orange,
                                                    face3: &yellow,
                                                    face4: &red,
                                                    rowFace1: 1,
                                                    colFace1: 0,
                                                    rowFace2: indexCubeType,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType,
                                                    rowFace4: 0,
                                                    colFace4: indexCubeType - 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right Edge
        result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                face2: &orange,
                                                face3: &yellow,
                                                face4: &red,
                                                rowFace1: 1,
                                                colFace1: indexCubeType,
                                                rowFace2: 0,
                                                colFace2: 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: 0,
                                                rowFace4: indexCubeType,
                                                colFace4: indexCubeType - 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Left corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                face2: &orange,
                                                face3: &yellow,
                                                face4: &red,
                                                rowFace1: 1,
                                                colFace1: 1,
                                                rowFace2: indexCubeType - 1,
                                                colFace2: 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: indexCubeType - 1,
                                                rowFace4: 1,
                                                colFace4: indexCubeType - 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                face2: &orange,
                                                face3: &yellow,
                                                face4: &red,
                                                rowFace1: 1,
                                                colFace1: indexCubeType - 1,
                                                rowFace2: 1,
                                                colFace2: 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: 1,
                                                rowFace4: indexCubeType - 1,
                                                colFace4: indexCubeType - 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Center of the center
        if CubeUtils.is5x5Or7x7Cube(cubeType) {
            result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                    face2: &orange,
                                                    face3: &yellow,
                                                    face4: &red,
                                                    rowFace1: 1,
                                                    colFace1: indexCubeType / 2,
                                                    rowFace2: indexCubeType / 2,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType / 2,
                                                    rowFace4: indexCubeType / 2,
                                                    colFace4: indexCubeType - 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        if CubeUtils.is6x6Or7x7Cube(cubeType) {
            //Left center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                    face2: &orange,
                                                    face3: &yellow,
                                                    face4: &red,
                                                    rowFace1: 1,
                                                    colFace1: 2,
                                                    rowFace2: indexCubeType - 2,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType - 2,
                                                    rowFace4: 2,
                                                    colFace4: indexCubeType - 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &white,
                                                    face2: &orange,
                                                    face3: &yellow,
                                                    face4: &red,
                                                    rowFace1: 1,
                                                    colFace1: indexCubeType - 2,
                                                    rowFace2: 2,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: 2,
                                                    rowFace4: indexCubeType - 2,
                                                    colFace4: indexCubeType - 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        return SwapResult(mainFace: mainBlue,
                          face1: white,
                          face2: orange,
                          face3: yellow,
                          face4: red)
    }
    
    func turn3Bw() {
        
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
