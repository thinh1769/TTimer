//
//  TurnLService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnLInterface {
    var mainFace: [[PieceColor]] { get }
    var face1: [[PieceColor]] { get }
    var face2: [[PieceColor]] { get }
    var face3: [[PieceColor]] { get }
    var face4: [[PieceColor]] { get }
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
    var mainFace: [[PieceColor]]
    var face1: [[PieceColor]]
    var face2: [[PieceColor]]
    var face3: [[PieceColor]]
    var face4: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnL(isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainFace = CubeUtils.swapIn1Face(&mainFace,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        //Left corner multi face
        var result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
        result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                face2: &face2,
                                                face3: &face3,
                                                face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
        
        return SwapResult(mainFace: mainFace,
                          face1: face1,
                          face2: face2,
                          face3: face3,
                          face4: face4)
    }
    
    mutating func turnLw(isPrime: Bool,
                         isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        //Left Edge
        var result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
        result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                face2: &face2,
                                                face3: &face3,
                                                face4: &face4,
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
        result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                face2: &face2,
                                                face3: &face3,
                                                face4: &face4,
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
        result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                face2: &face2,
                                                face3: &face3,
                                                face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
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
        
        return SwapResult(mainFace: mainFace,
                          face1: face1,
                          face2: face2,
                          face3: face3,
                          face4: face4)
    }
    
    func turn3Lw() {
        
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        face1 = result.face1
        face2 = result.face2
        face3 = result.face3
        face4 = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType) 
    {
        self.mainFace = mainFace
        self.face1 = face1
        self.face2 = face2
        self.face3 = face3
        self.face4 = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
