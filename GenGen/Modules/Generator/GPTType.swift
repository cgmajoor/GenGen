//
//  GPTType.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import UIKit

enum GPTType {
    case defaultGenerate
    case ai2Cents
    case rhyme
    case joke
    case mnemonic
    
    var title: String {
        switch self {
        case .defaultGenerate: return Texts.gptDefaultGenerateTitle
        case .ai2Cents: return Texts.gptAI2CentsTitle
        case .rhyme: return Texts.gptRhymeTitle
        case .joke: return Texts.gptJokeTitle
        case .mnemonic:  return Texts.gptMnemonicTitle
        }
    }
    
    var color: UIColor {
        switch self {
        case .defaultGenerate: return AppTheme.Generator.Color.generateDefaultBackgroundColor
        case .ai2Cents: return AppTheme.Generator.Color.ai2CentsBackgroundColor
        case .rhyme: return AppTheme.Generator.Color.gptRhymeBackgroundColor
        case .joke: return AppTheme.Generator.Color.gptJokeBackgroundColor
        case .mnemonic: return AppTheme.Generator.Color.gptMnemonicBackgroundColor
        }
    }
}
