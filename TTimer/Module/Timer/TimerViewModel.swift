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
    
    func uTurn() {
        swapFourValueOneSide(&white, row1: 0, col1: 0, row2: 0, col2: cubeType, row3: cubeType, col3: cubeType, row4: cubeType, col4: 0)
        
        
        swapFourValueOneSide(&white, row1: 0, col1: cubeType - 1, row2: cubeType - 1, col2: cubeType, row3: cubeType, col3: cubeType - 1, row4: cubeType - 1, col4: 0)
        
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: 0, orangeRow: 0, orangeCol: 0, blueRow: 0, blueCol: 0, redRow: 0, redCol: 0)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType - 1, orangeRow: 0, orangeCol: cubeType - 1, blueRow: 0, blueCol: cubeType - 1, redRow: 0, redCol: cubeType - 1)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType, orangeRow: 0, orangeCol: cubeType, blueRow: 0, blueCol: cubeType, redRow: 0, redCol: cubeType)
    }
    
    func swapFourValueOneSide
(_ matrix: inout [[PieceColor]], row1: Int, col1: Int, row2: Int, col2: Int, row3: Int, col3: Int, row4: Int, col4: Int) {
        let temp1 = matrix[row1][col1]
        let temp2 = matrix[row2][col2]
        let temp3 = matrix[row3][col3]
        let temp4 = matrix[row4][col4]

        matrix[row1][col1] = temp4
        matrix[row2][col2] = temp1
        matrix[row3][col3] = temp2
        matrix[row4][col4] = temp3
    }
    
    func swapFourValueMultiSideWhite
    (greenRow: Int, greenCol: Int, orangeRow: Int, orangeCol: Int, blueRow: Int, blueCol: Int, redRow: Int, redCol: Int) {
        let temp1 = green[greenRow][greenCol]
        let temp2 = orange[orangeRow][orangeCol]
        let temp3 = blue[blueRow][blueCol]
        let temp4 = red[redRow][redCol]

        green[greenRow][greenCol] = temp4
        orange[orangeRow][orangeCol] = temp1
        blue[blueRow][blueCol] = temp2
        red[redRow][redCol] = temp3
    }
}
