//
//  AppTheme.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

// MARK: - Asset list

enum GGColor: String {
    case ggWhite
    case ggLightGray
    case ggDarkGray
    case ggGray
    case ggBlack
    case ggPink

    var uiColor: UIColor {
        return UIColor(named: self.rawValue) ?? .systemBackground
    }
}

enum GGImage: String {
    case logo
    case help
    case magicWand
    case book

    var uiImage: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}

enum GGFont: String {
    case arialRoundedMTBold = "ArialRoundedMTBold"
    case futuraMedium = "Futura-Medium"
}

// MARK: - App's style tree

struct AppTheme {

    struct TabBar {
        struct Color {
            static var selectedItem = GGColor.ggDarkGray.uiColor
            static var unselectedItem = GGColor.ggGray.uiColor
            static var background = GGColor.ggLightGray.uiColor
        }
        struct Image {
            static var generator = GGImage.magicWand.uiImage
            static var library = GGImage.book.uiImage
        }
    }

    struct Main {
        struct Color {
            static var background = GGColor.ggWhite.uiColor
            static var labelBackground = GGColor.ggLightGray.uiColor
            static var labelTitle = GGColor.ggBlack.uiColor
            static var buttonBackground = GGColor.ggDarkGray.uiColor
            static var buttonTitle = GGColor.ggWhite.uiColor
        }
        struct FontStyle {
            static var buttonTitle = UIFont(name: GGFont.arialRoundedMTBold.rawValue, size: 20.0) ?? UIFont.preferredFont(forTextStyle: .headline)
            static var generationLabel = UIFont(name: GGFont.futuraMedium.rawValue, size: 24.0) ?? UIFont.preferredFont(forTextStyle: .headline)
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
            static var logo = GGImage.logo.uiImage
            static var help = GGImage.help.uiImage
        }
        struct Color {
            static var library = GGColor.ggPink.uiColor
        }
        struct FontStyle {
            static var title = UIFont(name: GGFont.arialRoundedMTBold.rawValue, size: 26.0) ?? UIFont.preferredFont(forTextStyle: .headline)
        }
    }

}
