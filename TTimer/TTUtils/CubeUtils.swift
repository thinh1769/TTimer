//
//  CubeUtils.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 12/01/2024.
//

import Foundation

class CubeUtils {
    static func isOddCube(_ cubeType: CubeType) -> Bool {
        return cubeType == .three || cubeType == .five || cubeType == .seven
    }
    
    static func isBigCube(_ cubeType: CubeType) -> Bool {
        return cubeType != .two && cubeType != .three
    }

    static func is6x6Or7x7Cube(_ cubeType: CubeType) -> Bool {
        return cubeType == .six || cubeType == .seven
    }
    
    static func is5x5Or7x7Cube(_ cubeType: CubeType) -> Bool {
        return cubeType == .five || cubeType == .seven
    }
    
    static func swapIn1Face(_ face: inout [[PieceColor]],
                            cubeType: CubeType,
                            isPrime: Bool,
                            isTwo: Bool) -> [[PieceColor]] {
        let indexCubeType = cubeType.rawValue - 1
        
        //Corner
        face = swap4Value(&face,
                          row1: 0,
                          col1: 0,
                          row2: 0,
                          col2: indexCubeType,
                          row3: indexCubeType,
                          col3: indexCubeType,
                          row4: indexCubeType,
                          col4: 0,
                          isPrime: isPrime,
                          isTwo: isTwo)
        
        //Center edge
        if isOddCube(cubeType) {
            face = swap4Value(&face,
                       row1: 0,
                       col1: indexCubeType / 2,
                       row2: indexCubeType / 2,
                       col2: indexCubeType,
                       row3: indexCubeType,
                       col3: indexCubeType / 2,
                       row4: indexCubeType / 2,
                       col4: 0,
                       isPrime: isPrime,
                       isTwo: isTwo)
        }
        
        if isBigCube(cubeType) {
            //Corner of center
            face = swap4Value(&face,
                       row1: 1,
                       col1: 1,
                       row2: 1,
                       col2: indexCubeType - 1,
                       row3: indexCubeType - 1,
                       col3: indexCubeType - 1,
                       row4: indexCubeType - 1,
                       col4: 1,
                       isPrime: isPrime,
                       isTwo: isTwo)
            
            //Left edge
            face = swap4Value(&face,
                       row1: 0,
                       col1: 1,
                       row2: 1,
                       col2: indexCubeType,
                       row3: indexCubeType,
                       col3: indexCubeType - 1,
                       row4: indexCubeType - 1,
                       col4: 0,
                       isPrime: isPrime,
                       isTwo: isTwo)
            
            //Right edge
            face = swap4Value(&face,
                       row1: 0,
                       col1: indexCubeType - 1,
                       row2: indexCubeType - 1,
                       col2: indexCubeType,
                       row3: indexCubeType,
                       col3: 1,
                       row4: 1,
                       col4: 0,
                       isPrime: isPrime,
                       isTwo: isTwo)
        }
        
        if is6x6Or7x7Cube(cubeType) {
            //2nd piece left of the edge
            face = swap4Value(&face,
                       row1: 0,
                       col1: 2,
                       row2: 2,
                       col2: indexCubeType,
                       row3: indexCubeType,
                       col3: indexCubeType - 2,
                       row4: indexCubeType - 2,
                       col4: 0,
                       isPrime: isPrime,
                       isTwo: isTwo)
            
            //2nd piece right of the edge
            face = swap4Value(&face,
                       row1: 0,
                       col1: indexCubeType - 2,
                       row2: indexCubeType - 2,
                       col2: indexCubeType,
                       row3: indexCubeType,
                       col3: 2,
                       row4: 2,
                       col4: 0,
                       isPrime: isPrime,
                       isTwo: isTwo)
            
            //2nd left of the center second layer
            face = swap4Value(&face,
                       row1: 1,
                       col1: 2,
                       row2: 2,
                       col2: indexCubeType - 1,
                       row3: indexCubeType - 1,
                       col3: indexCubeType - 2,
                       row4: indexCubeType - 2,
                       col4: 1,
                       isPrime: isPrime,
                       isTwo: isTwo)
            
            //2nd right of the center second layer
            face = swap4Value(&face,
                       row1: 1,
                       col1: indexCubeType - 2,
                       row2: indexCubeType - 2,
                       col2: indexCubeType - 1,
                       row3: indexCubeType - 1,
                       col3: 2,
                       row4: 2,
                       col4: 1,
                       isPrime: isPrime,
                       isTwo: isTwo)
        }
        
        //Center of the center second layer
        if is5x5Or7x7Cube(cubeType) {
            face = swap4Value(&face,
                       row1: 1,
                       col1: indexCubeType / 2,
                       row2: indexCubeType / 2,
                       col2: indexCubeType - 1,
                       row3: indexCubeType - 1,
                       col3: indexCubeType / 2,
                       row4: indexCubeType / 2,
                       col4: 1,
                       isPrime: isPrime,
                       isTwo: isTwo)
        }
        
        return face
    }
    
    static func swap4Value(_ face: inout [[PieceColor]],
                           row1: Int,
                           col1: Int,
                           row2: Int,
                           col2: Int,
                           row3: Int,
                           col3: Int,
                           row4: Int,
                           col4: Int,
                           isPrime: Bool,
                           isTwo: Bool
    ) -> [[PieceColor]] {
        
        let cell1 = face[row1][col1]
        let cell2 = face[row2][col2]
        let cell3 = face[row3][col3]
        let cell4 = face[row4][col4]
        
        if isPrime {
            face[row4][col4] = cell1
            face[row1][col1] = cell2
            face[row2][col2] = cell3
            face[row3][col3] = cell4
        } else if isTwo {
            face[row4][col4] = cell2
            face[row1][col1] = cell3
            face[row2][col2] = cell4
            face[row3][col3] = cell1
        } else {
            face[row1][col1] = cell4
            face[row2][col2] = cell1
            face[row3][col3] = cell2
            face[row4][col4] = cell3
        }
        
        return face
    }
    
    static func swap4PiecesMultiFace(face1: inout [[PieceColor]],
                                     face2: inout [[PieceColor]],
                                     face3: inout [[PieceColor]],
                                     face4: inout [[PieceColor]],
                                     rowFace1: Int,
                                     colFace1: Int,
                                     rowFace2: Int,
                                     colFace2: Int,
                                     rowFace3: Int,
                                     colFace3: Int,
                                     rowFace4: Int,
                                     colFace4: Int,
                                     isPrime: Bool,
                                     isTwo: Bool
    ) -> SwapResult {
        
        let cell1 = face1[rowFace1][colFace1]
        let cell2 = face2[rowFace2][colFace2]
        let cell3 = face3[rowFace3][colFace3]
        let cell4 = face4[rowFace4][colFace4]
        
        if isPrime {
            face1[rowFace1][colFace1] = cell2
            face2[rowFace2][colFace2] = cell3
            face3[rowFace3][colFace3] = cell4
            face4[rowFace4][colFace4] = cell1
        } else if isTwo {
            face1[rowFace1][colFace1] = cell3
            face2[rowFace2][colFace2] = cell4
            face3[rowFace3][colFace3] = cell1
            face4[rowFace4][colFace4] = cell2
        } else {
            face1[rowFace1][colFace1] = cell4
            face2[rowFace2][colFace2] = cell1
            face3[rowFace3][colFace3] = cell2
            face4[rowFace4][colFace4] = cell3
        }
        
        return SwapResult(mainFace: nil,
                          face1: face1,
                          face2: face2,
                          face3: face3,
                          face4: face4)
//        switch face {
//        case .white:
//            let cell1 = green[rowFace1][colFace1]
//            let cell2 = orange[rowFace2][colFace2]
//            let cell3 = blue[rowFace3][colFace3]
//            let cell4 = red[rowFace4][colFace4]
//            
//            if isPrime {
//                green[rowFace1][colFace1] = cell2
//                orange[rowFace2][colFace2] = cell3
//                blue[rowFace3][colFace3] = cell4
//                red[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                green[rowFace1][colFace1] = cell3
//                orange[rowFace2][colFace2] = cell4
//                blue[rowFace3][colFace3] = cell1
//                red[rowFace4][colFace4] = cell2
//            } else {
//                green[rowFace1][colFace1] = cell4
//                orange[rowFace2][colFace2] = cell1
//                blue[rowFace3][colFace3] = cell2
//                red[rowFace4][colFace4] = cell3
//            }
//            
//        case .green:
//            let cell1 = yellow[rowFace1][colFace1]
//            let cell2 = orange[rowFace2][colFace2]
//            let cell3 = white[rowFace3][colFace3]
//            let cell4 = red[rowFace4][colFace4]
//            
//            if isPrime {
//                yellow[rowFace1][colFace1] = cell2
//                orange[rowFace2][colFace2] = cell3
//                white[rowFace3][colFace3] = cell4
//                red[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                yellow[rowFace1][colFace1] = cell3
//                orange[rowFace2][colFace2] = cell4
//                white[rowFace3][colFace3] = cell1
//                red[rowFace4][colFace4] = cell2
//            } else {
//                yellow[rowFace1][colFace1] = cell4
//                orange[rowFace2][colFace2] = cell1
//                white[rowFace3][colFace3] = cell2
//                red[rowFace4][colFace4] = cell3
//            }
//            
//        case .yellow:
//            let cell1 = blue[rowFace1][colFace1]
//            let cell2 = orange[rowFace2][colFace2]
//            let cell3 = green[rowFace3][colFace3]
//            let cell4 = red[rowFace4][colFace4]
//            
//            if isPrime {
//                blue[rowFace1][colFace1] = cell2
//                orange[rowFace2][colFace2] = cell3
//                green[rowFace3][colFace3] = cell4
//                red[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                blue[rowFace1][colFace1] = cell3
//                orange[rowFace2][colFace2] = cell4
//                green[rowFace3][colFace3] = cell1
//                red[rowFace4][colFace4] = cell2
//            } else {
//                blue[rowFace1][colFace1] = cell4
//                orange[rowFace2][colFace2] = cell1
//                green[rowFace3][colFace3] = cell2
//                red[rowFace4][colFace4] = cell3
//            }
//            
//        case .orange:
//            let cell1 = green[rowFace1][colFace1]
//            let cell2 = yellow[rowFace2][colFace2]
//            let cell3 = blue[rowFace3][colFace3]
//            let cell4 = white[rowFace4][colFace4]
//            
//            if isPrime {
//                green[rowFace1][colFace1] = cell2
//                yellow[rowFace2][colFace2] = cell3
//                blue[rowFace3][colFace3] = cell4
//                white[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                green[rowFace1][colFace1] = cell3
//                yellow[rowFace2][colFace2] = cell4
//                blue[rowFace3][colFace3] = cell1
//                white[rowFace4][colFace4] = cell2
//            } else {
//                green[rowFace1][colFace1] = cell4
//                yellow[rowFace2][colFace2] = cell1
//                blue[rowFace3][colFace3] = cell2
//                white[rowFace4][colFace4] = cell3
//            }
//            
//        case .red:
//            let cell1 = green[rowFace1][colFace1]
//            let cell2 = white[rowFace2][colFace2]
//            let cell3 = blue[rowFace3][colFace3]
//            let cell4 = yellow[rowFace4][colFace4]
//            
//            if isPrime {
//                green[rowFace1][colFace1] = cell2
//                white[rowFace2][colFace2] = cell3
//                blue[rowFace3][colFace3] = cell4
//                yellow[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                green[rowFace1][colFace1] = cell3
//                white[rowFace2][colFace2] = cell4
//                blue[rowFace3][colFace3] = cell1
//                yellow[rowFace4][colFace4] = cell2
//            } else {
//                green[rowFace1][colFace1] = cell4
//                white[rowFace2][colFace2] = cell1
//                blue[rowFace3][colFace3] = cell2
//                yellow[rowFace4][colFace4] = cell3
//            }
//            
//        case .blue:
//            let cell1 = white[rowFace1][colFace1]
//            let cell2 = orange[rowFace2][colFace2]
//            let cell3 = yellow[rowFace3][colFace3]
//            let cell4 = red[rowFace4][colFace4]
//            
//            if isPrime {
//                white[rowFace1][colFace1] = cell2
//                orange[rowFace2][colFace2] = cell3
//                yellow[rowFace3][colFace3] = cell4
//                red[rowFace4][colFace4] = cell1
//            } else if isTwo {
//                white[rowFace1][colFace1] = cell3
//                orange[rowFace2][colFace2] = cell4
//                yellow[rowFace3][colFace3] = cell1
//                red[rowFace4][colFace4] = cell2
//            } else {
//                white[rowFace1][colFace1] = cell4
//                orange[rowFace2][colFace2] = cell1
//                yellow[rowFace3][colFace3] = cell2
//                red[rowFace4][colFace4] = cell3
//            }
//        }
    }
}
