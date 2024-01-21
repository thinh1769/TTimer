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

class TimerViewModel {
    let bag = DisposeBag()
    var scrambleList: [String]
    var cubeType: CubeType
    
    init() {
        scrambleList = [""]
        cubeType = .three
    }
    
    func generateRandomScrambleList() -> String {
        var scramble = ""
        var length = 0
        let allScramble = Scramble.allCases
        let allScramble2Layers = Scramble2Layers.allCases
        let allScramble3Layers = Scramble3Layers.allCases
        
        var combinedCase = allScramble.map { "\($0.rawValue)" }
        var usedScrambleCharacter = ""
        
        switch cubeType {
        case .two:
            length = ScrambleLength.two.rawValue
        case .three:
            length = ScrambleLength.three.rawValue
        case .four:
            length = ScrambleLength.four.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
        case .five:
            length = ScrambleLength.five.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
        case .six:
            length = ScrambleLength.six.rawValue
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        case .seven:
            length = ScrambleLength.seven.rawValue
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        }
        
        while length > 0 {
            let randomScramble = combinedCase.randomElement() ?? ""
            if !randomScramble.contains(usedScrambleCharacter) {
                scramble += "\(randomScramble) "
                scrambleList.append(randomScramble)
                usedScrambleCharacter = randomScramble.filter { $0.isUppercase }
                length -= 1
            }
        }
        
        return String(scramble.dropLast())
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
