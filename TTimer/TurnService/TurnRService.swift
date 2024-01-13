//
//  TurnRService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 13/01/2024.
//

import Foundation
import SwiftUI

protocol TurnRInterface {
    var mainFace: [[PieceColor]] { get }
    var face1: [[PieceColor]] { get }
    var face2: [[PieceColor]] { get }
    var face3: [[PieceColor]] { get }
    var face4: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnR(isPrime: Bool,
                        isTwo: Bool
    ) -> SwapResult
    
    func turnRw()
    
    func turn3Rw()
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnRService: TurnRInterface {
    var mainFace: [[PieceColor]]
    var face1: [[PieceColor]]
    var face2: [[PieceColor]]
    var face3: [[PieceColor]]
    var face4: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnR(isPrime: Bool,
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
                                                    rowFace1: 0,
                                                    colFace1: indexCubeType,
                                                    rowFace2: 0,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType,
                                                    colFace3: 0,
                                                    rowFace4: 0,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner multi face
        result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                face2: &face2,
                                                face3: &face3,
                                                face4: &face4,
                                                rowFace1: indexCubeType,
                                                colFace1: indexCubeType,
                                                rowFace2: indexCubeType,
                                                colFace2: indexCubeType,
                                                rowFace3: 0,
                                                colFace3: 0,
                                                rowFace4: indexCubeType,
                                                colFace4: indexCubeType,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        if CubeUtils.isOddCube(cubeType) {
            //Center edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
                                                    rowFace1: indexCubeType / 2,
                                                    colFace1: indexCubeType,
                                                    rowFace2: indexCubeType / 2,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType / 2,
                                                    colFace3: 0,
                                                    rowFace4: indexCubeType / 2,
                                                    colFace4: indexCubeType,
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
                                                    rowFace1: 1,
                                                    colFace1: indexCubeType,
                                                    rowFace2: 1,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: 0,
                                                    rowFace4: 1,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: indexCubeType,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: indexCubeType,
                                                    rowFace3: 1,
                                                    colFace3: 0,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: indexCubeType,
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
                                                    rowFace1: 2,
                                                    colFace1: indexCubeType,
                                                    rowFace2: 2,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType - 2,
                                                    colFace3: 0,
                                                    rowFace4: 2,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //2nd piece right of the edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &face1,
                                                    face2: &face2,
                                                    face3: &face3,
                                                    face4: &face4,
                                                    rowFace1: indexCubeType - 2,
                                                    colFace1: indexCubeType,
                                                    rowFace2: indexCubeType - 2,
                                                    colFace2: indexCubeType,
                                                    rowFace3: 2,
                                                    colFace3: 0,
                                                    rowFace4: indexCubeType - 2,
                                                    colFace4: indexCubeType,
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
    
    func turnRw() {
        
    }
    
    func turn3Rw() {
        
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
         cubeType: CubeType) {
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
