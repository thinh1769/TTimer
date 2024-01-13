//
//  TurnU.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 12/01/2024.
//

import Foundation
import SwiftUI

protocol TurnUInterface {
    var mainWhite: [[PieceColor]] { get }
    var green: [[PieceColor]] { get }
    var orange: [[PieceColor]] { get }
    var blue: [[PieceColor]] { get }
    var red: [[PieceColor]] { get }
    var cubeType: CubeType { get }
    
    mutating func turnU(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult

    mutating func reassignFace(_ result: SwapResult)
}

struct TurnUService: TurnUInterface {
    var mainWhite: [[PieceColor]]
    var green: [[PieceColor]]
    var orange: [[PieceColor]]
    var blue: [[PieceColor]]
    var red: [[PieceColor]]
    var cubeType: CubeType
    
    mutating func turnU(_ layer: Layer,
                        isPrime: Bool,
                        isTwo: Bool)
    -> SwapResult {
        let indexCubeType = cubeType.rawValue - 1
        
        mainWhite = CubeUtils.swapIn1Face(&mainWhite,
                                         cubeType: cubeType,
                                         isPrime: isPrime,
                                         isTwo: isTwo)
        
        for index in 0...layer.rawValue {
            //Left corner multi face
            var result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 0,
                                                        rowFace2: index,
                                                        colFace2: 0,
                                                        rowFace3: index,
                                                        colFace3: 0,
                                                        rowFace4: index,
                                                        colFace4: 0,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
            
            reassignFace(result)
            
            //Right corner multi face
            result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                    face2: &orange,
                                                    face3: &blue,
                                                    face4: &red,
                                                    rowFace1: index,
                                                    colFace1: indexCubeType,
                                                    rowFace2: index,
                                                    colFace2: indexCubeType,
                                                    rowFace3: index,
                                                    colFace3: indexCubeType,
                                                    rowFace4: index,
                                                    colFace4: indexCubeType,
                                                    isPrime: isPrime,
                                                    isTwo: isTwo)
            reassignFace(result)
            
            if CubeUtils.isOddCube(cubeType) {
                //Center edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType / 2,
                                                        rowFace2: index,
                                                        colFace2: indexCubeType / 2,
                                                        rowFace3: index,
                                                        colFace3: indexCubeType / 2,
                                                        rowFace4: index,
                                                        colFace4: indexCubeType / 2,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
            
            if CubeUtils.isBigCube(cubeType) {
                //Left edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 1,
                                                        rowFace2: index,
                                                        colFace2: 1,
                                                        rowFace3: index,
                                                        colFace3: 1,
                                                        rowFace4: index,
                                                        colFace4: 1,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //Right edge one face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType - 1,
                                                        rowFace2: index,
                                                        colFace2: indexCubeType - 1,
                                                        rowFace3: index,
                                                        colFace3: indexCubeType - 1,
                                                        rowFace4: index,
                                                        colFace4: indexCubeType - 1,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
            
            if CubeUtils.is6x6Or7x7Cube(cubeType) {
                //2nd piece left of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: 2,
                                                        rowFace2: index,
                                                        colFace2: 2,
                                                        rowFace3: index,
                                                        colFace3: 2,
                                                        rowFace4: index,
                                                        colFace4: 2,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
                
                //2nd piece right of the edge multi face
                result = CubeUtils.swap4PiecesMultiFace(face1: &green,
                                                        face2: &orange,
                                                        face3: &blue,
                                                        face4: &red,
                                                        rowFace1: index,
                                                        colFace1: indexCubeType - 2,
                                                        rowFace2: index,
                                                        colFace2: indexCubeType - 2,
                                                        rowFace3: index,
                                                        colFace3: indexCubeType - 2,
                                                        rowFace4: index,
                                                        colFace4: indexCubeType - 2,
                                                        isPrime: isPrime,
                                                        isTwo: isTwo)
                
                reassignFace(result)
            }
        }

        return SwapResult(mainFace: mainWhite,
                          face1: green,
                          face2: orange,
                          face3: blue,
                          face4: red)
    }
    
    mutating func reassignFace(_ result: SwapResult) {
        if let whiteFace = result.mainFace {
            mainWhite = whiteFace
        }
        green = result.face1
        orange = result.face2
        blue = result.face3
        red = result.face4
    }
    
    init(mainFace: [[PieceColor]],
         face1: [[PieceColor]],
         face2: [[PieceColor]],
         face3: [[PieceColor]],
         face4: [[PieceColor]],
         cubeType: CubeType)
    {
        self.mainWhite = mainFace
        self.green = face1
        self.orange = face2
        self.blue = face3
        self.red = face4
        self.cubeType = cubeType
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
