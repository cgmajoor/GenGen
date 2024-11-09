//
//  AppDependencies.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import Foundation

public final class AppDependencies {
    public static let shared = AppDependencies()

    lazy var coreDataStack = CoreDataStack()
    lazy var favoriteService: FavoriteServiceProtocol = FavoriteService(coreDataStack: coreDataStack)
    lazy var wordService: WordServiceProtocol = WordService(coreDataStack: coreDataStack)
    lazy var ruleService: RuleServiceProtocol = RuleService(coreDataStack: coreDataStack)
    lazy var bookService = BookService(coreDataStack: coreDataStack, ruleService: ruleService, wordService: wordService)
}
