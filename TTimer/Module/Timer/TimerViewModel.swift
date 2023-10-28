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
    
    func turnU() {
        swapFourValueOneSide(&white, row1: 0, col1: 0, row2: 0, col2: cubeType, row3: cubeType, col3: cubeType, row4: cubeType, col4: 0)
        
        
        swapFourValueOneSide(&white, row1: 0, col1: cubeType - 1, row2: cubeType - 1, col2: cubeType, row3: cubeType, col3: cubeType - 1, row4: cubeType - 1, col4: 0)
        
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: 0, orangeRow: 0, orangeCol: 0, blueRow: 0, blueCol: 0, redRow: 0, redCol: 0, isReversed: false)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType - 1, orangeRow: 0, orangeCol: cubeType - 1, blueRow: 0, blueCol: cubeType - 1, redRow: 0, redCol: cubeType - 1, isReversed: false)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType, orangeRow: 0, orangeCol: cubeType, blueRow: 0, blueCol: cubeType, redRow: 0, redCol: cubeType, isReversed: false)
    }
    
    func turnUPrime() {
        // corner
        swapFourValueOneSide(&white, row1: 0, col1: 0, row2: cubeType, col2: 0, row3: cubeType, col3: cubeType, row4: 0, col4: cubeType)
        
        //edge
        swapFourValueOneSide(&white, row1: 0, col1: cubeType - 1, row2: cubeType - 1, col2: 0, row3: cubeType, col3: cubeType - 1, row4: cubeType - 1, col4: cubeType)
        
        // other side
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: 0, orangeRow: 0, orangeCol: 0, blueRow: 0, blueCol: 0, redRow: 0, redCol: 0, isReversed: true)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType - 1, orangeRow: 0, orangeCol: cubeType - 1, blueRow: 0, blueCol: cubeType - 1, redRow: 0, redCol: cubeType - 1, isReversed: true)
        swapFourValueMultiSideWhite(greenRow: 0, greenCol: cubeType, orangeRow: 0, orangeCol: cubeType, blueRow: 0, blueCol: cubeType, redRow: 0, redCol: cubeType, isReversed: true)
    }
    
    func turnF() {
        swapFourValueOneSide(&green, row1: 0, col1: 0, row2: 0, col2: cubeType, row3: cubeType, col3: cubeType, row4: cubeType, col4: 0)
        
        
        swapFourValueOneSide(&green, row1: 0, col1: cubeType - 1, row2: cubeType - 1, col2: cubeType, row3: cubeType, col3: cubeType - 1, row4: cubeType - 1, col4: 0)
        
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: 0, orangeRow: 0, orangeCol: cubeType, whiteRow: cubeType, whiteCol: cubeType, redRow: cubeType, redCol: 0, isPrime: false)
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: cubeType - 1, orangeRow: cubeType - 1, orangeCol: cubeType, whiteRow: cubeType, whiteCol: cubeType - 1, redRow: cubeType - 1, redCol: 0, isPrime: false)
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: cubeType, orangeRow: cubeType, orangeCol: cubeType, whiteRow: cubeType, whiteCol: 0, redRow: 0, redCol: 0, isPrime: false)
    }
    
    func turnFPrime() {
        swapFourValueOneSide(&green, row1: 0, col1: 0, row2: cubeType, col2: 0, row3: cubeType, col3: cubeType, row4: 0, col4: cubeType)
        
        
        swapFourValueOneSide(&green, row1: 0, col1: cubeType - 1, row2: cubeType - 1, col2: 0, row3: cubeType, col3: cubeType - 1, row4: cubeType - 1, col4: cubeType)
        
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: 0, orangeRow: 0, orangeCol: cubeType, whiteRow: cubeType, whiteCol: cubeType, redRow: cubeType, redCol: 0, isPrime: true)
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: cubeType - 1, orangeRow: cubeType - 1, orangeCol: cubeType, whiteRow: cubeType, whiteCol: cubeType - 1, redRow: cubeType - 1, redCol: 0, isPrime: true)
        swapFourValueMultiSideGreen(yellowRow: 0, yellowCol: cubeType, orangeRow: cubeType, orangeCol: cubeType, whiteRow: cubeType, whiteCol: 0, redRow: 0, redCol: 0, isPrime: true)
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
    (greenRow: Int, greenCol: Int, orangeRow: Int, orangeCol: Int, blueRow: Int, blueCol: Int, redRow: Int, redCol: Int, isReversed: Bool) {
        let temp1 = green[greenRow][greenCol]
        let temp2 = orange[orangeRow][orangeCol]
        let temp3 = blue[blueRow][blueCol]
        let temp4 = red[redRow][redCol]
        
        if !isReversed {
            green[greenRow][greenCol] = temp4
            orange[orangeRow][orangeCol] = temp1
            blue[blueRow][blueCol] = temp2
            red[redRow][redCol] = temp3
        } else {
            green[greenRow][greenCol] = temp2
            orange[orangeRow][orangeCol] = temp3
            blue[blueRow][blueCol] = temp4
            red[redRow][redCol] = temp1
        }
    }
    
    func swapFourValueMultiSideGreen
    (yellowRow: Int, yellowCol: Int, orangeRow: Int, orangeCol: Int, whiteRow: Int, whiteCol: Int, redRow: Int, redCol: Int, isPrime: Bool) {
        let temp1 = yellow[yellowRow][yellowCol]
        let temp2 = orange[orangeRow][orangeCol]
        let temp3 = white[whiteRow][whiteCol]
        let temp4 = red[redRow][redCol]
        
        if !isPrime {
            yellow[yellowRow][yellowCol] = temp4
            orange[orangeRow][orangeCol] = temp1
            white[whiteRow][whiteCol] = temp2
            red[redRow][redCol] = temp3
        } else {
            yellow[yellowRow][yellowCol] = temp2
            orange[orangeRow][orangeCol] = temp3
            white[whiteRow][whiteCol] = temp4
            red[redRow][redCol] = temp1
        }
    }
}
