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
    
    mutating func turnD(isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult
    
    mutating func turnDw(isPrime: Bool,
                         isTwo: Bool)
    -> SwapResult
    
    func turn3Dw()
    
    mutating func reassignFace(_ result: SwapResult)
}

struct TurnDService: TurnDInterface {
    var mainYellow: [[PieceColor]]
    var blue: [[PieceColor]]
    var orange: [[PieceColor]]
    var green: [[PieceColor]]
    var red: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnD(isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainYellow = CubeUtils.swapIn1Face(&mainYellow,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        //Left corner multi face
        var result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: indexCubeType,
                                                    rowFace2: indexCubeType,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner multi face
        result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                face2: &orange,
                                                face3: &green,
                                                face4: &red,
                                                rowFace1: indexCubeType,
                                                colFace1: 0,
                                                rowFace2: indexCubeType,
                                                colFace2: 0,
                                                rowFace3: indexCubeType,
                                                colFace3: 0,
                                                rowFace4: indexCubeType,
                                                colFace4: 0,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        if CubeUtils.isOddCube(cubeType) {
            //Center edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: indexCubeType / 2,
                                                    rowFace2: indexCubeType,
                                                    colFace2: indexCubeType / 2,
                                                    rowFace3: indexCubeType,
                                                    colFace3: indexCubeType / 2,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType / 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        if CubeUtils.isBigCube(cubeType) {
            //Left edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: indexCubeType - 1,
                                                    rowFace2: indexCubeType,
                                                    colFace2: indexCubeType - 1,
                                                    rowFace3: indexCubeType,
                                                    colFace3: indexCubeType - 1,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType - 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: 1,
                                                    rowFace2: indexCubeType,
                                                    colFace2: 1,
                                                    rowFace3: indexCubeType,
                                                    colFace3: 1,
                                                    rowFace4: indexCubeType,
                                                    colFace4: 1,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        if CubeUtils.is6x6Or7x7Cube(cubeType) {
            //2nd piece left of the edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: indexCubeType - 2,
                                                    rowFace2: indexCubeType,
                                                    colFace2: indexCubeType - 2,
                                                    rowFace3: indexCubeType,
                                                    colFace3: indexCubeType - 2,
                                                    rowFace4: indexCubeType,
                                                    colFace4: indexCubeType - 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //2nd piece right of the edge multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType,
                                                    colFace1: 2,
                                                    rowFace2: indexCubeType,
                                                    colFace2: 2,
                                                    rowFace3: indexCubeType,
                                                    colFace3: 2,
                                                    rowFace4: indexCubeType,
                                                    colFace4: 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        return SwapResult(mainFace: mainYellow,
                          face1: blue,
                          face2: orange,
                          face3: green,
                          face4: red)
    }
    
    mutating func turnDw(isPrime: Bool,
                         isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        //Left Edge
        var result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: indexCubeType,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: indexCubeType,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
        
        reassignFace(result)
        
        //Right Edge
        result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                face2: &orange,
                                                face3: &green,
                                                face4: &red,
                                                rowFace1: indexCubeType - 1,
                                                colFace1: 0,
                                                rowFace2: indexCubeType - 1,
                                                colFace2: 0,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: 0,
                                                rowFace4: indexCubeType - 1,
                                                colFace4: 0,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Left corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                face2: &orange,
                                                face3: &green,
                                                face4: &red,
                                                rowFace1: indexCubeType - 1,
                                                colFace1: indexCubeType - 1,
                                                rowFace2: indexCubeType - 1,
                                                colFace2: indexCubeType - 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: indexCubeType - 1,
                                                rowFace4: indexCubeType - 1,
                                                colFace4: indexCubeType - 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Right corner center
        result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                face2: &orange,
                                                face3: &green,
                                                face4: &red,
                                                rowFace1: indexCubeType - 1,
                                                colFace1: 1,
                                                rowFace2: indexCubeType - 1,
                                                colFace2: 1,
                                                rowFace3: indexCubeType - 1,
                                                colFace3: 1,
                                                rowFace4: indexCubeType - 1,
                                                colFace4: 1,
                                                isPrime: isPrime,
                                                isTwo: isTwo)
        
        reassignFace(result)
        
        //Center of the center
        if CubeUtils.is5x5Or7x7Cube(cubeType) {
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: indexCubeType / 2,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: indexCubeType / 2,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType / 2,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: indexCubeType / 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        if CubeUtils.is6x6Or7x7Cube(cubeType) {
            //Left center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: indexCubeType - 2,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: indexCubeType - 2,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: indexCubeType - 2,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: indexCubeType - 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
            
            //Right center of the center
            result = CubeUtils.swap4PiecesMultiFace(face1: &blue,
                                                    face2: &orange,
                                                    face3: &green,
                                                    face4: &red,
                                                    rowFace1: indexCubeType - 1,
                                                    colFace1: 2,
                                                    rowFace2: indexCubeType - 1,
                                                    colFace2: 2,
                                                    rowFace3: indexCubeType - 1,
                                                    colFace3: 2,
                                                    rowFace4: indexCubeType - 1,
                                                    colFace4: 2,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            
            reassignFace(result)
        }
        
        return SwapResult(mainFace: mainYellow,
                          face1: blue,
                          face2: orange,
                          face3: green,
                          face4: red)
    }
    
    func turn3Dw() {
        
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
