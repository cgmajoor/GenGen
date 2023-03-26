//
//  AppTheme.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

enum GGColor: String {
    case background
    case tabBarBackground
    case tabBarItemSelected
    case tabBarItemUnselected

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

struct AppTheme {

    struct TabBar {
        static var selectedItemColor = GGColor.tabBarItemSelected.uiColor
        static var unselectedItemColor = GGColor.tabBarItemUnselected.uiColor
        static var backgroundColor = GGColor.tabBarBackground.uiColor

    }

    struct Main {
        enum Color {
            static var background = GGColor.background.uiColor
        }
    }

    struct Navigation {
        enum Image {
            static var logo = GGImage.logo.uiImage
            static var help = GGImage.help.uiImage
        }
    }

}
