//
//  AppTheme.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

enum GGColor: String {
    case GGBackground
    case GGTabBarItemSelected
    case GGTabBarItemUnselected

    var uiColor: UIColor {
        return UIColor(named: self.rawValue) ?? .systemBackground
    }
}

struct AppTheme {

    struct TabBar {
        static var selectedItemColor = GGColor.GGTabBarItemSelected.uiColor
        static var unselectedItemColor = GGColor.GGTabBarItemUnselected.uiColor

    }

    struct Main {
        enum Color {
            static var background = GGColor.GGBackground.uiColor
        }
    }

}
