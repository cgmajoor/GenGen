//
//  GPTType.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import UIKit

enum GPTType {
    case ai2Cents
    case rhyme
    case joke
    case mnemonic
    case eco
    case calm
    case careerAdvisor

    var title: String {
        switch self {
        case .ai2Cents: return Texts.aiBot2CentsTitle
        case .rhyme: return Texts.aiBotRhymeTitle
        case .joke: return Texts.aiBotJokeTitle
        case .mnemonic:  return Texts.aiBotMnemonicTitle
        case .eco:  return Texts.aiBotEcoTitle
        case .calm:  return Texts.aiBotCalmTitle
        case .careerAdvisor:  return Texts.aiBotCareerAdvisorTitle
        }
    }
    
    var color: UIColor {
        switch self {
        case .ai2Cents: return AppTheme.Generator.Color.aiBot2CentsBackgroundColor
        case .rhyme: return AppTheme.Generator.Color.aiBotRhymeBackgroundColor
        case .joke: return AppTheme.Generator.Color.aiBotJokeBackgroundColor
        case .mnemonic: return AppTheme.Generator.Color.aiBotMnemonicBackgroundColor
        case .eco: return AppTheme.Generator.Color.aiBotEcoBackgroundColor
        case .calm: return AppTheme.Generator.Color.aiBotCalmBackgroundColor
        case .careerAdvisor: return AppTheme.Generator.Color.aiBotCareerAdvisorBackgroundColor
        }
    }

    var backgroundImage: UIImage {
        switch self {
        case .ai2Cents: return AppTheme.Generator.Image.aiBot2Cents
        case .rhyme: return AppTheme.Generator.Image.aiBotRhyme
        case .joke: return AppTheme.Generator.Image.aiBotJoke
        case .mnemonic: return AppTheme.Generator.Image.aiBotMnemonic
        case .eco: return AppTheme.Generator.Image.aiBotEco
        case .calm: return AppTheme.Generator.Image.aiBotCalming
        case .careerAdvisor: return AppTheme.Generator.Image.aiBotCareerAdvisor
        }
    }

    var useCase: GenerateTextWithOpenAIUseCaseProtocol {
        switch self {
        case .ai2Cents: return GenerateAI2CentsUseCase()
        case .rhyme: return GenerateRhymeUseCase()
        case .joke: return GenerateJokeUseCase()
        case .mnemonic: return GenerateMnemonicUseCase()
        case .eco: return GenerateEcoGuidanceUseCase()
        case .calm: return GenerateCalmingAffirmationUseCase()
        case .careerAdvisor: return GenerateCareerAdviceUseCase()
        }
    }

    var tokenLimit: Int {
         switch self {
         case .ai2Cents: return 20
         case .rhyme: return 80
         case .joke: return 50
         case .mnemonic: return 50
         case .eco: return 25
         case .calm: return 25
         case .careerAdvisor: return 25
         }
     }
}
