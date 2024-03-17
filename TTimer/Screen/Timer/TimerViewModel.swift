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
    let genScramble: GenerateScrambleService?
    var currentScramble: [String] = []
    var currentTime = 0
    var previousTime = 0
    var timeInterval = 0.01
    @Published var cubeType: CubeType
    @Published var scramble: [String] = [""]
    @Published var time: [TimeItem] = []
    @Published var mo3: Int = 0
    @Published var ao5: Int = 0
    @Published var ao12: Int = 0
    @Published var ao50: Int = 0
    @Published var count: Int = 0
    
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
    
    func calculateTime() {
        if count >= AverageType.mo3.rawValue {
            mo3 = TTUtils.calculateTime(time, averageType: .mo3)
        }
        
        if count >= AverageType.ao5.rawValue {
            ao5 = TTUtils.calculateTime(time, averageType: .ao5)
        }
        
        if count >= AverageType.ao12.rawValue {
            ao12 = TTUtils.calculateTime(time, averageType: .ao12)
        }
        if count >= AverageType.ao50.rawValue {
            ao50 = TTUtils.calculateTime(time, averageType: .ao50)
        }
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
