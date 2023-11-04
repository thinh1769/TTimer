//
//  TimerViewModel.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 22/10/2023.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift

class TimerViewModel {
    let bag = DisposeBag()
    let whiteData = BehaviorRelay<[PieceColor]>(value: [])
    let greenData = BehaviorRelay<[PieceColor]>(value: [])
    let yellowData = BehaviorRelay<[PieceColor]>(value: [])
    let orangeData = BehaviorRelay<[PieceColor]>(value: [])
    let redData = BehaviorRelay<[PieceColor]>(value: [])
    let blueData = BehaviorRelay<[PieceColor]>(value: [])
    
    var white : [[PieceColor]] = [
        [.white, .white, .white],
        [.white, .white, .white],
        [.white, .white, .white]
    ]
    
    var green : [[PieceColor]] = [
        [.green, .green, .green],
        [.green, .green, .green],
        [.green, .green, .green]
    ]
    
    var yellow : [[PieceColor]] = [
        [.yellow, .yellow, .yellow],
        [.yellow, .yellow, .yellow],
        [.yellow, .yellow, .yellow]
    ]
    
    var orange : [[PieceColor]] = [
        [.orange, .orange, .orange],
        [.orange, .orange, .orange],
        [.orange, .orange, .orange]
    ]
    
    var red : [[PieceColor]] = [
        [.red, .red, .red],
        [.red, .red, .red],
        [.red, .red, .red]
    ]
    
    var blue : [[PieceColor]] = [
        [.blue, .blue, .blue],
        [.blue, .blue, .blue],
        [.blue, .blue, .blue]
    ]
    var cubeType = 2
    
    func turnU(isPrime: Bool = false) {
        ///White side
        //Corner
        swapFourCellsOneSide(&white,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        
        //Edge
        swapFourCellsOneSide(&white,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)
        
        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &green,
                               matrix2: &orange,
                               matrix3: &blue,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: 0,
                               rowMatrix2: 0,
                               colMatrix2: 0,
                               rowMatrix3: 0,
                               colMatrix3: 0,
                               rowMatrix4: 0,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &green,
                               matrix2: &orange,
                               matrix3: &blue,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType,
                               rowMatrix2: 0,
                               colMatrix2: cubeType,
                               rowMatrix3: 0,
                               colMatrix3: cubeType,
                               rowMatrix4: 0,
                               colMatrix4: cubeType,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &green,
                               matrix2: &orange,
                               matrix3: &blue,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType / 2,
                               rowMatrix2: 0,
                               colMatrix2: cubeType / 2,
                               rowMatrix3: 0,
                               colMatrix3: cubeType / 2,
                               rowMatrix4: 0,
                               colMatrix4: cubeType / 2,
                               isPrime: isPrime)
    }
    
    func turnF(isPrime: Bool = false) {
        ///Green side
        //Corner
        swapFourCellsOneSide(&green,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        //Edge
        swapFourCellsOneSide(&green,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)
        
        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &orange,
                               matrix3: &white,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: 0,
                               rowMatrix2: 0,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType,
                               rowMatrix4: cubeType,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &orange,
                               matrix3: &white,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType,
                               rowMatrix2: cubeType,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: 0,
                               rowMatrix4: 0,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &orange,
                               matrix3: &white,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType / 2,
                               rowMatrix2: cubeType / 2,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType / 2,
                               rowMatrix4: cubeType / 2,
                               colMatrix4: 0,
                               isPrime: isPrime)
    }

    func turnL(isPrime: Bool = false) {
        ///Orange side
        //Corner
        swapFourCellsOneSide(&orange,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        //Edge
        swapFourCellsOneSide(&orange,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)
        
        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &blue,
                               matrix3: &white,
                               matrix4: &green,
                               rowMatrix1: cubeType,
                               colMatrix1: 0,
                               rowMatrix2: 0,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: 0,
                               rowMatrix4: cubeType,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &blue,
                               matrix3: &white,
                               matrix4: &green,
                               rowMatrix1: 0,
                               colMatrix1: 0,
                               rowMatrix2: cubeType,
                               colMatrix2: cubeType,
                               rowMatrix3: 0,
                               colMatrix3: 0,
                               rowMatrix4: 0,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &blue,
                               matrix3: &white,
                               matrix4: &green,
                               rowMatrix1: cubeType / 2,
                               colMatrix1: 0,
                               rowMatrix2: cubeType / 2,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType / 2,
                               colMatrix3: 0,
                               rowMatrix4: cubeType / 2,
                               colMatrix4: 0,
                               isPrime: isPrime)
    }
    
    func turnR(isPrime: Bool = false) {
        /// Orange side
        // Corner
        swapFourCellsOneSide(&red,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        // Edge
        swapFourCellsOneSide(&red,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)
        
        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &green,
                               matrix3: &white,
                               matrix4: &blue,
                               rowMatrix1: 0,
                               colMatrix1: cubeType,
                               rowMatrix2: 0,
                               colMatrix2: cubeType,
                               rowMatrix3: 0,
                               colMatrix3: cubeType,
                               rowMatrix4: cubeType,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &green,
                               matrix3: &white,
                               matrix4: &blue,
                               rowMatrix1: cubeType,
                               colMatrix1: cubeType,
                               rowMatrix2: cubeType,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType,
                               rowMatrix4: 0,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &yellow,
                               matrix2: &green,
                               matrix3: &white,
                               matrix4: &blue,
                               rowMatrix1: cubeType / 2,
                               colMatrix1: cubeType,
                               rowMatrix2: cubeType / 2,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType / 2,
                               colMatrix3: cubeType,
                               rowMatrix4: cubeType / 2,
                               colMatrix4: 0,
                               isPrime: isPrime)
    }
    
    func turnD(isPrime: Bool = false) {
        /// Yellow side
        // Corner
        swapFourCellsOneSide(&yellow,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        // Edge
        swapFourCellsOneSide(&yellow,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)
        
        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &blue,
                               matrix2: &orange,
                               matrix3: &green,
                               matrix4: &red,
                               rowMatrix1: cubeType,
                               colMatrix1: cubeType,
                               rowMatrix2: cubeType,
                               colMatrix2: cubeType,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType,
                               rowMatrix4: cubeType,
                               colMatrix4: cubeType,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &blue,
                               matrix2: &orange,
                               matrix3: &green,
                               matrix4: &red,
                               rowMatrix1: cubeType,
                               colMatrix1: 0,
                               rowMatrix2: cubeType,
                               colMatrix2: 0,
                               rowMatrix3: cubeType,
                               colMatrix3: 0,
                               rowMatrix4: cubeType,
                               colMatrix4: 0,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &blue,
                               matrix2: &orange,
                               matrix3: &green,
                               matrix4: &red,
                               rowMatrix1: cubeType,
                               colMatrix1: cubeType / 2,
                               rowMatrix2: cubeType,
                               colMatrix2: cubeType / 2,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType / 2,
                               rowMatrix4: cubeType,
                               colMatrix4: cubeType / 2,
                               isPrime: isPrime)
    }
    
    func turnB(isPrime: Bool = false) {
        /// Blue side
        // Corner
        swapFourCellsOneSide(&blue,
                             row1: 0,
                             col1: 0,
                             row2: 0,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType,
                             row4: cubeType,
                             col4: 0,
                             isPrime: isPrime)
        // Edge
        swapFourCellsOneSide(&blue,
                             row1: 0,
                             col1: cubeType / 2,
                             row2: cubeType / 2,
                             col2: cubeType,
                             row3: cubeType,
                             col3: cubeType / 2,
                             row4: cubeType / 2,
                             col4: 0,
                             isPrime: isPrime)

        ///Other side
        //Left corner
        swapFourCellsMultiSide(matrix1: &white,
                               matrix2: &orange,
                               matrix3: &yellow,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: 0,
                               rowMatrix2: cubeType,
                               colMatrix2: 0,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType,
                               rowMatrix4: 0,
                               colMatrix4: cubeType,
                               isPrime: isPrime)
        //Right corner
        swapFourCellsMultiSide(matrix1: &white,
                               matrix2: &orange,
                               matrix3: &yellow,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType,
                               rowMatrix2: 0,
                               colMatrix2: 0,
                               rowMatrix3: cubeType,
                               colMatrix3: 0,
                               rowMatrix4: cubeType,
                               colMatrix4: cubeType,
                               isPrime: isPrime)
        //Edge
        swapFourCellsMultiSide(matrix1: &white,
                               matrix2: &orange,
                               matrix3: &yellow,
                               matrix4: &red,
                               rowMatrix1: 0,
                               colMatrix1: cubeType / 2,
                               rowMatrix2: cubeType / 2,
                               colMatrix2: 0,
                               rowMatrix3: cubeType,
                               colMatrix3: cubeType / 2,
                               rowMatrix4: cubeType / 2,
                               colMatrix4: cubeType,
                               isPrime: isPrime)
    }
    
    func swapFourCellsOneSide(_ matrix: inout [[PieceColor]],
                              row1: Int,
                              col1: Int,
                              row2: Int,
                              col2: Int,
                              row3: Int,
                              col3: Int,
                              row4: Int,
                              col4: Int,
                              isPrime: Bool
    ) {
        let temp1 = matrix[row1][col1]
        let temp2 = matrix[row2][col2]
        let temp3 = matrix[row3][col3]
        let temp4 = matrix[row4][col4]
        
        if !isPrime {
            matrix[row1][col1] = temp4
            matrix[row2][col2] = temp1
            matrix[row3][col3] = temp2
            matrix[row4][col4] = temp3
        } else {
            matrix[row4][col4] = temp1
            matrix[row1][col1] = temp2
            matrix[row2][col2] = temp3
            matrix[row3][col3] = temp4
        }
    }
    
    func swapFourCellsMultiSide(matrix1: inout [[PieceColor]],
                                matrix2: inout [[PieceColor]],
                                matrix3: inout [[PieceColor]],
                                matrix4: inout [[PieceColor]],
                                rowMatrix1: Int,
                                colMatrix1: Int,
                                rowMatrix2: Int,
                                colMatrix2: Int,
                                rowMatrix3: Int,
                                colMatrix3: Int,
                                rowMatrix4: Int,
                                colMatrix4: Int,
                                isPrime: Bool
    ) {
        let temp1 = matrix1[rowMatrix1][colMatrix1]
        let temp2 = matrix2[rowMatrix2][colMatrix2]
        let temp3 = matrix3[rowMatrix3][colMatrix3]
        let temp4 = matrix4[rowMatrix4][colMatrix4]

        if !isPrime {
            matrix1[rowMatrix1][colMatrix1] = temp4
            matrix2[rowMatrix2][colMatrix2] = temp1
            matrix3[rowMatrix3][colMatrix3] = temp2
            matrix4[rowMatrix4][colMatrix4] = temp3
        } else {
            matrix1[rowMatrix1][colMatrix1] = temp2
            matrix2[rowMatrix2][colMatrix2] = temp3
            matrix3[rowMatrix3][colMatrix3] = temp4
            matrix4[rowMatrix4][colMatrix4] = temp1
        }
    }
}
