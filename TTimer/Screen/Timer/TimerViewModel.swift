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
import SwiftUI
import Combine

class TimerViewModel {
    let bag = DisposeBag()
    var cubeType: CubeType
    let genScramble: GenerateScrambleService?
    @Published var scramble: [String] = [""]
    @Published var time: TimeItem?
    var currentScramble: [String] = []
    var currentTime = 0
    var previousTime = 0
    var timeInterval = 0.01
    
    init() {
        cubeType = .three
        genScramble = .init()
    }
    
    func generateScramble() -> String {
        var scrambleString = ""
        if let scrambleArray = genScramble?.generateScramble(cubeType: cubeType) {
            self.scramble = scrambleArray
            for scramCharacter in scrambleArray {
                currentScramble.append(scramCharacter)
                scrambleString += "\(scramCharacter) "
            }
        }
        return String(scrambleString.dropLast())
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
