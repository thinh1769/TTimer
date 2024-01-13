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
    
    mutating func turnL(isPrime: Bool,
                        isTwo: Bool
    ) -> SwapResult
    
    mutating func turnLw(isPrime: Bool,
                         isTwo: Bool
    ) -> SwapResult
    
    func turn3Lw()
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnLService: TurnLInterface {
    var mainOrange: [[PieceColor]]
    var yellow: [[PieceColor]]
    var blue: [[PieceColor]]
    var white: [[PieceColor]]
    var green: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnL(isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainOrange = CubeUtils.swapIn1Face(&mainOrange,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        //Left corner multi face
        var result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType,
                                                    colFace1: 0,
                                                    rowFace2: indexCubeType,
                                                    colFace2: 0,
                                                    rowFace3: 0,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner multi face
        result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                face2: &blue,
                                                face3: &white,
                                                face4: &green,
                                                rowFace1: 0,
                                                colFace1: 0,
                                                rowFace2: 0,
                                                colFace2: 0,
                                                rowFace3: indexCubeType,
                                                colFace3: indexCubeType,
                                                rowFace4: 0,
                                                colFace4: 0,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        if CubeUtils.isOddCube(cubeType) {
            //Center edge of multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType / 2,
                                                    colFace1: 0,
                                                    rowFace2: indexCubeType / 2,
                                                    colFace2: 0,
                                                    rowFace3: indexCubeType / 2,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType / 2,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            reassignFace(result)
            
        }
        
        if CubeUtils.isBigCube(cubeType) {
            //Left edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: 0,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: 0,
                                                    rowFace3: 1,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: 1,
                                                    colFace1: 0,
                                                    rowFace2: 1,
                                                    colFace2: 0,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType,
                                                    rowFace4: 1,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        if CubeUtils.is6x6Or7x7Cube(cubeType) {
            //2nd piece left of the edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType - 2,
                                                    colFace1: 0,
                                                    rowFace2: indexCubeType - 2,
                                                    colFace2: 0,
                                                    rowFace3: 2,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType - 2,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //2nd piece right of the edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: 2,
                                                    colFace1: 0,
                                                    rowFace2: 2,
                                                    colFace2: 0,
                                                    rowFace3: indexCubeType - 2,
                                                    colFace3: indexCubeType,
                                                    rowFace4: 2,
                                                    colFace4: 0,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        return SwapResult(mainFace: mainOrange,
                          face1: yellow,
                          face2: blue,
                          face3: white,
                          face4: green)
    }
    
    mutating func turnLw(isPrime: Bool,
                         isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        //Left Edge
        var result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType,
                                                    colFace1: 1,
                                                    rowFace2: indexCubeType,
                                                    colFace2: 1,
                                                    rowFace3: 0,
                                                    colFace3: indexCubeType - 1,
                                                    rowFace4: indexCubeType,
                                                    colFace4: 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right Edge
        result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                face2: &blue,
                                                face3: &white,
                                                face4: &green,
                                                rowFace1: 0,
                                                colFace1: 1,
                                                rowFace2: 0,
                                                colFace2: 1,
                                                rowFace3: indexCubeType,
                                                colFace3: indexCubeType - 1,
                                                rowFace4: 0,
                                                colFace4: 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Left corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                face2: &blue,
                                                face3: &white,
                                                face4: &green,
                                                rowFace1: indexCubeType - 1,
                                                colFace1: 1,
                                                rowFace2: indexCubeType - 1,
                                                colFace2: 1,
                                                rowFace3: 1,
                                                colFace3: indexCubeType - 1,
                                                rowFace4: indexCubeType - 1,
                                                colFace4: 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                face2: &blue,
                                                face3: &white,
                                                face4: &green,
                                                rowFace1: 1,
                                                colFace1: 1,
                                                rowFace2: 1,
                                                colFace2: 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: indexCubeType - 1,
                                                rowFace4: 1,
                                                colFace4: 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Center of the center
        if CubeUtils.is5x5Or7x7Cube(cubeType) {
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType / 2,
                                                    colFace1: 1,
                                                    rowFace2: indexCubeType / 2,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType / 2,
                                                    colFace3: indexCubeType - 1,
                                                    rowFace4: indexCubeType / 2,
                                                    colFace4: 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
        }
        
        if CubeUtils.is6x6Or7x7Cube(cubeType) {
            //Left center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: indexCubeType - 2,
                                                    colFace1: 1,
                                                    rowFace2: indexCubeType - 2,
                                                    colFace2: 1,
                                                    rowFace3: 2,
                                                    colFace3: indexCubeType - 1,
                                                    rowFace4: indexCubeType - 2,
                                                    colFace4: 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &yellow,
                                                    face2: &blue,
                                                    face3: &white,
                                                    face4: &green,
                                                    rowFace1: 2,
                                                    colFace1: 1,
                                                    rowFace2: 2,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType - 2,
                                                    colFace3: indexCubeType - 1,
                                                    rowFace4: 2,
                                                    colFace4: 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        return SwapResult(mainFace: mainOrange,
                          face1: yellow,
                          face2: blue,
                          face3: white,
                          face4: green)
    }
    
    func turn3Lw() {
        
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
