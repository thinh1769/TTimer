//
//  TTConstant.swift
//  TTimer
//
//  Created by Nguyễn Thịnh on 23/10/2023.
//

import Foundation

struct Constants {
    static public let ignore2x2ScrambleCharacterSet = [Scramble.D.rawValue, Scramble.B.rawValue, Scramble.L.rawValue]
    static public let upDownScrambleCharacterSet = [Scramble.U.rawValue, Scramble.D.rawValue]
    static public let leftRightScrambleCharacterSet = [Scramble.L.rawValue, Scramble.R.rawValue]
    static public let frontBackScrambleCharacterSet = [Scramble.F.rawValue, Scramble.B.rawValue]
}

enum TextSize: CGFloat {
    case smallBody = 13
    case body = 16
    case title = 50
}

enum AverageType: Int {
    case mo3 = 3
    case ao5 = 5
    case ao12 = 12
    case ao50 = 50
    case ao100 = 100
}

enum Layer: Int {
    case one = 0
    case two = 1
    case three = 2
}

typealias SwapResult = (mainFace: [[PieceColor]]?,
                        face1: [[PieceColor]],
                        face2: [[PieceColor]],
                        face3: [[PieceColor]],
                        face4: [[PieceColor]])

enum FaceColor {
    case white
    case green
    case yellow
    case orange
    case red
    case blue
}

enum PieceColor: String {
    case white = "white_piece"
    case green = "green_piece"
    case yellow = "yellow_piece"
    case orange = "orange_piece"
    case red = "red_piece"
    case blue = "blue_piece"
}

enum CubeType: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
}

enum PieceSize: CGFloat {
    case two = 20
    case three = 14
    case four = 10
    case five = 8
    case six = 7
    case seven = 6
}

enum NumberDecimalPlaces: Int {
    case two = 100
    case three = 1000
}

enum TimeFormat: String {
    case second = "%d"
    case secondMillisecond = "%d.%02d"
    case minuteSecond = "%d:%02d"
    case minuteSecondMillisecond = "%d:%02d.%02d"
}

enum Penalty: Int {
    case none = 0
    case plus2 = 1
    case dnf = 2
}

enum ScrambleLength: Int {
    case two = 9
    case three = 20
    case four = 40
    case five = 60
    case six = 80
    case seven = 100
}

enum Scramble: String, CaseIterable {
    case U = "U"
    case UPrime = "U'"
    case U2 = "U2"
    
    case F = "F"
    case FPrime = "F'"
    case F2 = "F2"
    
    case L = "L"
    case LPrime = "L'"
    case L2 = "L2"
    
    case R = "R"
    case RPrime = "R'"
    case R2 = "R2"
    
    case D = "D"
    case DPrime = "D'"
    case D2 = "D2"
    
    case B = "B"
    case BPrime = "B'"
    case B2 = "B2"
}

enum Scramble2Layers: String, CaseIterable {
    case Uw = "Uw"
    case UwPrime = "Uw'"
    case Uw2 = "Uw2"
    
    case Fw = "Fw"
    case FwPrime = "Fw'"
    case Fw2 = "Fw2"
    
    case Lw = "Lw"
    case LwPrime = "Lw'"
    case Lw2 = "Lw2"

    case Rw = "Rw"
    case RwPrime = "Rw'"
    case Rw2 = "Rw2"
    
    case Dw = "Dw"
    case DwPrime = "Dw'"
    case Dw2 = "Dw2"
    
    case Bw = "Bw"
    case BwPrime = "Bw'"
    case Bw2 = "Bw2"
}

enum Scramble3Layers: String, CaseIterable {
    case _3Uw = "3Uw"
    case _3UwPrime = "3Uw'"
    case _3Uw2 = "3Uw2"

    case _3Fw = "3Fw"
    case _3FwPrime = "3Fw'"
    case _3Fw2 = "3Fw2"

    case _3Lw = "3Lw"
    case _3LwPrime = "3L'"
    case _3Lw2 = "3Lw2"

    case _3Rw = "3Rw"
    case _3RwPrime = "3Rw'"
    case _3Rw2 = "3Rw2"

    case _3Dw = "3Dw"
    case _3DwPrime = "3Dw'"
    case _3Dw2 = "3Dw2"

    case _3Bw = "3Bw"
    case _3BwPrime = "3Bw'"
    case _3Bw2 = "3Bw2"
}




