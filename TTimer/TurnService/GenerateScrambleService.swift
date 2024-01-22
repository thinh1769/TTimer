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
    func detectLayer(_ scrambleCharacter: String) -> Layer
}

struct GenerateScrambleService: GenerateScramble {
    func generateScramble(cubeType: CubeType) -> [String] {
        var scrambleList = [""]
        var length = 0
        let allScramble1Layer = Scramble.allCases
        let allScramble2Layers = Scramble2Layers.allCases
        let allScramble3Layers = Scramble3Layers.allCases
        
        var combinedCase = allScramble1Layer.map { "\($0.rawValue)" }
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
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        case .seven:
            length = ScrambleLength.seven.rawValue
            combinedCase += allScramble2Layers.map { "\($0.rawValue)" }
            combinedCase += allScramble3Layers.map { "\($0.rawValue)" }
        }
        
        while length > 0 {
            let randomScramble = combinedCase.randomElement() ?? ""
            if getMainCharacter(randomScramble) != getMainCharacter(usedScrambleCharacter) ||
                detectLayer(randomScramble) != detectLayer(usedScrambleCharacter) {
                scrambleList.append(randomScramble)
                usedScrambleCharacter = randomScramble
                length -= 1
            }
        }
        scrambleList.removeFirst()
        return scrambleList
    }
    
    func detectLayer(_ scrambleCharacter: String) -> Layer {
        if !scrambleCharacter.contains("w") && !scrambleCharacter.contains("3") {
            return .one
        } else if scrambleCharacter.contains("w") && !scrambleCharacter.contains("3") {
            return .two
        } else {
            return .three
        }
    }
    
    func getMainCharacter(_ scrambleCharacter: String) -> String {
        return scrambleCharacter.filter { $0.isUppercase }
    }
    
    init() {
    }
}

#Preview(body: {
    TTViewControllerPreview {
        TimerViewController()
    }
})
