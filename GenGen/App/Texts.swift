//
//  Texts.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

struct Texts {
    // MARK: - Identifiers
    static let libraryTableViewCell = String(describing: LibraryTableViewCell.self)
    static let bookTableViewCell = String(describing: BookTableViewCell.self)
    static let rulesTableViewCell = String(describing: RulesTableViewCell.self)

    // MARK: - Color Asset Names
    static let ggWhite = "ggWhite"
    static let ggLightGray = "ggLightGray"
    static let ggDarkGray = "ggDarkGray"
    static let ggGray = "ggGray"
    static let ggBlack = "ggBlack"
    static let ggPink = "ggPink"
    static let ggYellow = "ggYellow"
    static let ggGreen = "ggGreen"

    // MARK: - Image Asset Names
    static let logo = "logo"
    static let help = "help"
    static let magicWand = "magicWand"
    static let book = "book"
    static let add = "add"
    static let rules = "rules"
    static let checkMark = "checkMark"
    static let pickUp = "pickUp"

    // MARK: - Font Names
    static let arialRoundedMTBold = "ArialRoundedMTBold"
    static let futuraMedium = "Futura-Medium"

    // MARK: - TabBarItems
    static let generatorTabBarTitle = "Generator"
    static let libraryTabBarTitle = "Library"
    static let rulesTabBarTitle = "Rules"

    // MARK: - Navigation
    static let libraryNavigationTitle = "Library"
    static let rulesNavigationTitle = "Rules"
    static let ruleCreatorNavigationTitle = "New Rule"

    // MARK: - Generator
    static let generateButtonTitle = "Generate"

    // MARK: - Library
    static let addNewBookAlertTitle = "Enter a new book name"

    // MARK: - Book
    static let addNewWordAlertTitle = "Enter a word"

    // MARK: - PromptAlert
    static let promptAlertAddActionTitle = "Add"
    static let promptAlertCancelActionTitle = "Cancel"
}
