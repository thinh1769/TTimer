//
//  TTConstant.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 23/10/2023.
//

import Foundation

enum PieceColor: String {
    case white = "white_piece"
    case green = "green_piece"
    case yellow = "yellow_piece"
    case orange = "orange_piece"
    case red = "red_piece"
    case blue = "blue_piece"
}

enum CubeType: Int {
    case two = 1
    case three = 2
    case four = 3
    case five = 4
    case six = 5
    case seven = 6
}

enum PieceSize: CGFloat {
    case two = 20
    case three = 14
    case four = 10
    case five = 8
    case six = 7
    case seven = 6
}

enum ScrambleLength: Int {
    case two = 9
    case three = 20
    case four = 40
    case five = 60
    case six = 80
    case seven = 100
}

enum Scramble {
    case U
    case UPrime
    case U2
    case Uw
    case UwPrime
    case Uw2
    case _3Uw
    case _3UwPrime
    case _3Uw2
    
    case F
    case FPrime
    case F2
    case Fw
    case FwPrime
    case Fw2
    case _3Fw
    case _3FwPrime
    case _3Fw2
    
    case L
    case LPrime
    case L2
    case Lw
    case LwPrime
    case Lw2
    case _3Lw
    case _3LwPrime
    case _3Lw2
    
    case R
    case RPrime
    case R2
    case Rw
    case RwPrime
    case Rw2
    case _3Rw
    case _3RwPrime
    case _3Rw2
    
    case D
    case DPrime
    case D2
    case Dw
    case DwPrime
    case Dw2
    case _3Dw
    case _3DwPrime
    case _3Dw2
    
    case B
    case BPrime
    case B2
    case Bw
    case BwPrime
    case Bw2
    case _3Bw
    case _3BwPrime
    case _3Bw2
}

