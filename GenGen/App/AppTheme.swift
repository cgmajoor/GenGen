//
//  AppTheme.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

// MARK: - App's style tree
struct AppTheme {

    struct TabBar {
        struct Color {
            static var selectedItem = UIColor(named: Texts.ggDarkGray) ?? .systemBackground
            static var unselectedItem = UIColor(named: Texts.ggGray) ?? .systemBackground
            static var background = UIColor(named: Texts.ggLightGray) ?? .systemBackground
        }
        struct Image {
            static var generator = UIImage(named: Texts.magicWand) ?? UIImage()
            static var library = UIImage(named: Texts.book) ?? UIImage()
        }
    }

    struct Main {
        struct Color {
            static var background = UIColor(named: Texts.ggWhite) ?? .systemBackground

            static var labelBackground = UIColor(named: Texts.ggLightGray) ?? .systemBackground
            static var labelTitle = UIColor(named: Texts.ggBlack) ?? .systemFill

            static var buttonBackground = UIColor(named: Texts.ggDarkGray) ?? .systemBackground
            static var buttonTitle = UIColor(named: Texts.ggWhite) ?? .systemFill
        }
        struct FontStyle {
            static var buttonTitle = UIFont(name: Texts.arialRoundedMTBold, size: 20.0) ?? UIFont.preferredFont(forTextStyle: .headline)
            static var generationLabel = UIFont(name: Texts.futuraMedium, size: 24.0) ?? UIFont.preferredFont(forTextStyle: .headline)
            static var label = UIFont(name: Texts.futuraMedium, size: 20.0) ?? UIFont.preferredFont(forTextStyle: .headline)
        }
        struct Padding {
            static var horizontal: CGFloat = 20.0
            static var vertical: CGFloat = 10.0
        }
        struct Size {
            static var buttonHeight: CGFloat = 80.0
        }
    }

    struct Navigation {
        struct Image {
            static var logo = UIImage(named: Texts.logo) ?? UIImage()
            static var help = UIImage(named: Texts.help) ?? UIImage()
        }
        struct Color {
            static var library = UIColor(named: Texts.ggPink) ?? .systemFill
        }
        struct FontStyle {
            static var title = UIFont(name: Texts.arialRoundedMTBold, size: 26.0) ?? UIFont.preferredFont(forTextStyle: .headline)
        }
    }

}
