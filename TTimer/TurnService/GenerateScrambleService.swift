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
            return match2x2Conditions(scramCharacterSet)
        case .three:
            return matchMainCharacterCondition(scramCharacterSet)
        case .four:
            return matchMainCharacterCondition(scramCharacterSet)
        case .five:
            return matchMainCharacterCondition(scramCharacterSet)
        case .six:
            return matchMainCharacterCondition(scramCharacterSet)
        case .seven:
            return matchMainCharacterCondition(scramCharacterSet)
        }
        
//        return getMainCharacter(nextCharacter) != getMainCharacter(usedCharacter) ||
//        detectLayer(nextCharacter) != detectLayer(usedCharacter)
    }
    
    private func getMainCharacter(_ scrambleCharacter: String) -> String {
        return scrambleCharacter.filter { $0.isUppercase }
    }
    
    private func matchMainCharacterCondition(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        return getMainCharacter(scramCharacterSet.next) != getMainCharacter(scramCharacterSet.current)
    }
    
    private func match2x2Conditions(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
        if ["D", "L", "B"].contains(getMainCharacter(scramCharacterSet.next)) {
            return false
        } else {
            return matchMainCharacterCondition(scramCharacterSet)
        }
    }

//    private func isOppositeSides(_ scramCharacterSet: ScrambleCharacterSet) -> Bool {
//        if getMainCharacter(scramCharacterSet.previous) == "U" || getMainCharacter(scramCharacterSet.previous == "D") {
//            
//        }
//        
//        return true
//    }
//    
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
        var previous: String?
        var current: String
        var next: String
        
        init(previous: String? = nil, current: String, next: String) {
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
