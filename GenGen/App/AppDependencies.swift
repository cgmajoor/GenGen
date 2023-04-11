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
    lazy var bookService = BookService(coreDataStack: coreDataStack)
    lazy var wordService = WordService(coreDataStack: coreDataStack)
    lazy var ruleService = RuleService(coreDataStack: coreDataStack)
}
