//
//  GenerateScrambleService.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 22/01/2024.
//

import Foundation
import SwiftUI

protocol GenerateScramble {
    func generateScramble(cubeType: CubeType) -> [String]
}

struct GenerateScrambleService: GenerateScramble {
    func generateScramble(cubeType: CubeType) -> [String] {
        var scrambleList = [""]
        var length = 0
        let allScramble1Layer = Scramble.allCases
        let allScramble2Layers = Scramble2Layers.allCases
        let allScramble3Layers = Scramble3Layers.allCases
        
        var combinedCase = allScramble1Layer.map { "\($0.rawValue)" }
        var currentScrambleCharacter = ""
        var previousScrambleCharacter = ""
        
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
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        case .seven:
            length = ScrambleLength.seven.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        }
        
        while length > 0 {
            previousScrambleCharacter = currentScrambleCharacter
            let randomScramble = combinedCase.randomElement() ?? ""
            if isMatchConditions(ScrambleCharacterSet(previous: previousScrambleCharacter,
                                                      current: currentScrambleCharacter,
                                                      next: randomScramble),
                                 cubeType) {
                scrambleList.append(randomScramble)
                currentScrambleCharacter = randomScramble
                length -= 1
            }
        }
        scrambleList.removeFirst()
        return scrambleList
    }
    
    private func isMatchConditions(_ scramCharacterSet: ScrambleCharacterSet, _ cubeType: CubeType) -> Bool {
        switch cubeType {
        case .two:
            return isMatch2x2(scramCharacterSet)
        case .three:
            return isMatch3x3(scramCharacterSet)
        case .four:
            return isMatchMainLayer(scramCharacterSet)
        case .five:
            return isMatchMainLayer(scramCharacterSet)
        case .six:
            return isMatchMainLayer(scramCharacterSet)
        case .seven:
            return isMatchMainLayer(scramCharacterSet)
        }
        
//        return getMainCharacter(nextCharacter) != getMainCharacter(usedCharacter) ||
//        detectLayer(nextCharacter) != detectLayer(usedCharacter)
    }
    
    private func mainLayer(_ scrambleCharacter: String) -> String {
        return scrambleCharacter.filter { $0.isUppercase }
    }
    
    private func isMatchMainLayer(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        return mainLayer(scramCharacterSet.next) != mainLayer(scramCharacterSet.current)
    }
    
    private func isMatch2x2(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        return !Constants.ignore2x2ScrambleCharacterSet.contains(mainLayer(scramCharacterSet.next)) && isMatchMainLayer(scramCharacterSet)
    }
    
    private func isMatch3x3(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        return !isOppositeSides(scramCharacterSet) && isMatchMainLayer(scramCharacterSet)
    }
    
    private func isOppositeSides(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        let previous = mainLayer(scramCharacterSet.previous)
        let current = mainLayer(scramCharacterSet.current)
        let next = mainLayer(scramCharacterSet.next)
        
        if Constants.upDownScrambleCharacterSet.contains(previous) &&
            Constants.upDownScrambleCharacterSet.contains(current) &&
            Constants.upDownScrambleCharacterSet.contains(next) {
            return true
        } else if Constants.frontBackScrambleCharacterSet.contains(previous) &&
                    Constants.frontBackScrambleCharacterSet.contains(current) &&
                    Constants.frontBackScrambleCharacterSet.contains(next) {
            return true
        } else if Constants.leftRightScrambleCharacterSet.contains(previous) &&
                    Constants.leftRightScrambleCharacterSet.contains(current) &&
                    Constants.leftRightScrambleCharacterSet.contains(next) {
            return true
        }
        
        return false
    }
    
    private func detectLayer(_ scrambleCharacter: String) -> Layer {
        if !scrambleCharacter.contains("w") && !scrambleCharacter.contains("3") {
            return .one
        } else if scrambleCharacter.contains("w") && !scrambleCharacter.contains("3") {
            return .two
        } else {
            return .three
        }
    }
    
    init() {
    }
}

extension GenerateScrambleService {
    struct ScrambleCharacterSet {
        var previous: String
        var current: String
        var next: String
        
        init(previous: String, current: String, next: String) {
            self.previous = previous
            self.current = current
            self.next = next
        }
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
