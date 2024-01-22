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
    
    init() {
        cubeType = .three
        genScramble = .init()
    }
    
    func generateScramble() -> String {
        var scrambleString = ""
        if let scrambleArray = genScramble?.generateScramble(cubeType: cubeType) {
            self.scramble = scrambleArray
            for scramCharacter in scrambleArray {
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
