//
//  AppTheme.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

// MARK: - App's style tree
struct AppTheme {
    struct Padding {
        static var horizontal: CGFloat = 20.0
        static var vertical: CGFloat = 10.0
    }

    struct Color {
        static var ggOpenAI = UIColor(named: Texts.ggOpenAI) ?? .systemFill
        static var ggPink = UIColor(named: Texts.ggPink) ?? .systemFill
        static var ggMint = UIColor(named: Texts.ggMint) ?? .systemFill
        static var ggYellow = UIColor(named: Texts.ggYellow) ?? .systemFill
        static var ggLila = UIColor(named: Texts.ggLila) ?? .systemFill
        static var ggGreen = UIColor(named: Texts.ggGreen) ?? .systemFill
        static var ggBlue = UIColor(named: Texts.ggBlue) ?? .systemFill
    }

    struct TabBar {
        struct Color {
            static var selectedItem = UIColor(named: Texts.ggDarkGray) ?? .systemBackground
            static var unselectedItem = UIColor(named: Texts.ggGray) ?? .systemBackground
            static var background = UIColor(named: Texts.ggLightGray) ?? .systemBackground
        }
        struct Image {
            static var generator = UIImage(named: Texts.magicWand) ?? UIImage()
            static var library = UIImage(named: Texts.book) ?? UIImage()
            static var rules = UIImage(named: Texts.rules) ?? UIImage()
            static var favorites = UIImage(named: Texts.favorites) ?? UIImage()
        }
    }
    
    struct Main {
        struct Color {
            static var background = UIColor(named: Texts.ggWhite) ?? .systemBackground
            static var loadingOverlay = UIColor(named: Texts.ggOverlay) ?? .tertiarySystemBackground
            static var loadingOverlayTextColor = UIColor(named: Texts.ggOverlayTextColor) ?? .tertiarySystemBackground

            static var tableViewBackground = UIColor(named: Texts.ggLightGray) ?? .systemBackground
            
            static var labelBackground = UIColor(named: Texts.ggLightGray) ?? .systemBackground
            static var labelTitle = UIColor(named: Texts.ggDarkGray) ?? .systemFill
            
            static var buttonBackground = UIColor(named: Texts.ggDarkGray) ?? .systemBackground
            static var buttonTitle = UIColor(named: Texts.ggWhite) ?? .systemFill
        }
        struct FontStyle {
            static var buttonTitle = UIFont(name: Texts.arialRoundedMTBold, size: 20.0) ?? UIFont.preferredFont(forTextStyle: .headline)
            static var generationLabel = UIFont(name: Texts.futuraMedium, size: 24.0) ?? UIFont.preferredFont(forTextStyle: .headline)
            static var label = UIFont(name: Texts.futuraMedium, size: 20.0) ?? UIFont.preferredFont(forTextStyle: .headline)
        }
        struct Size {
            static var buttonHeight: CGFloat = 80.0
            static var squareIconHeight: CGFloat = 44.0
        }
        struct Image {
            static var pickUp = UIImage(named: Texts.pickUp) ?? UIImage()
            static var addFav = UIImage(named: Texts.addFav) ?? UIImage()
            static var downloadGenGen = UIImage(named: Texts.downloadGenGen) ?? UIImage()
            static var openAI = UIImage(named: Texts.openAI) ?? UIImage()
        }
    }

    struct Generator {
        struct Color {
            static var generateButton = UIColor(named: Texts.ggOpenAI) ?? .systemFill

            static var aiBot2CentsBackgroundColor = UIColor(named: Texts.ggOpenAI) ?? .systemBackground
            static var aiBotRhymeBackgroundColor = UIColor(named: Texts.ggPink) ?? .systemBackground
            static var aiBotJokeBackgroundColor = UIColor(named: Texts.ggYellow) ?? .systemBackground
            static var aiBotMnemonicBackgroundColor = UIColor(named: Texts.ggLila) ?? .systemBackground
            static var aiBotEcoBackgroundColor = UIColor(named: Texts.ggGreen) ?? .systemBackground
            static var aiBotCalmBackgroundColor = UIColor(named: Texts.ggBlue) ?? .systemBackground
            static var aiBotCareerAdvisorBackgroundColor = UIColor(named: Texts.ggMint) ?? .systemBackground
        }
        struct Size {
            static var gptCellHeight: CGFloat = 100.0
            static var gptCellWidth: CGFloat = 120.0
        }
        struct Image {
            static var aiBot2Cents = UIImage(named: Texts.aiBot2Cents) ?? UIImage()
            static var aiBotRhyme = UIImage(named: Texts.aiBotRhyme) ?? UIImage()
            static var aiBotJoke = UIImage(named: Texts.aiBotJoke) ?? UIImage()
            static var aiBotMnemonic = UIImage(named: Texts.aiBotMnemonic) ?? UIImage()
            static var aiBotEco = UIImage(named: Texts.aiBotEco) ?? UIImage()
            static var aiBotCalming = UIImage(named: Texts.aiBotCalming) ?? UIImage()
            static var aiBotCareerAdvisor = UIImage(named: Texts.aiBotCareerAdvisor) ?? UIImage()
        }
    }

    struct RuleCreator {
        struct Color {
            static var actionBackground = UIColor(named: Texts.ggYellow) ?? .systemBackground
            static var actionForeground = UIColor(named: Texts.ggDarkGray) ?? .systemFill
            static var ruleBackground = UIColor(named: Texts.ggLightYellow) ?? .systemBackground
        }
    }
    
    struct Onboarding {
        struct Image {
            static var onboarding1 = UIImage(named: Texts.onboarding1) ?? UIImage()
            static var onboarding2 = UIImage(named: Texts.onboarding2) ?? UIImage()
            static var onboarding3 = UIImage(named: Texts.onboarding3) ?? UIImage()
            static var onboarding4 = UIImage(named: Texts.onboarding4) ?? UIImage()
            static var onboarding5 = UIImage(named: Texts.onboarding5) ?? UIImage()
            static var onboarding6 = UIImage(named: Texts.onboarding6) ?? UIImage()
            static var onboarding7 = UIImage(named: Texts.onboarding7) ?? UIImage()
        }

        static var backgroundColors: [UIColor] = [
            UIColor(named: Texts.ggFixedLightGray) ?? .systemFill,
            UIColor(named: Texts.ggPink) ?? .systemFill,
            UIColor(named: Texts.ggYellow) ?? .systemFill,
            UIColor(named: Texts.ggGreen) ?? .systemFill,
            UIColor(named: Texts.ggLila) ?? .systemFill,
            UIColor(named: Texts.ggMint) ?? .systemFill,
            UIColor(named: Texts.ggOrange) ?? .systemFill,
        ]
    }
    
    struct Navigation {
        struct Image {
            static var logo = UIImage(named: Texts.logo) ?? UIImage()
            static var help = UIImage(named: Texts.help) ?? UIImage()
            static var add = UIImage(named: Texts.add) ?? UIImage()
            static var checkMark = UIImage(named: Texts.checkMark) ?? UIImage()
            static var close = UIImage(named: Texts.close) ?? UIImage()
        }
        struct Color {
            static var library = UIColor(named: Texts.ggPink) ?? .systemFill
            static var rules = UIColor(named: Texts.ggYellow) ?? .systemFill
            static var favorites = UIColor(named: Texts.ggGreen) ?? .systemFill
        }
        struct FontStyle {
            static var title = UIFont(name: Texts.arialRoundedMTBold, size: 26.0) ?? UIFont.preferredFont(forTextStyle: .headline)
        }
    }
}
