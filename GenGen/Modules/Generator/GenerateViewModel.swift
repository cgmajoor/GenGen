//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol Generating {
    var generatedStr: String { get }
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void)
    func getBooksWithWords(_ completion: @escaping (Result<[String: [String]], Error>) -> Void)
    func generate(_ completion: @escaping (Result<String, Error>) -> Void)
}

// MARK: - Generator
class GenerateViewModel: Generating {
    
    // MARK: - Properties
    var generatedStr: String = ""
    var activeRules: [Rule] = []
    private var activeBooksWithWords: [String: [String]] = [:]

    let ruleService: RuleServiceProtocol
    let bookService: BookServiceProtocol
    let wordService: WordServiceProtocol
    
    // MARK: - Initialization
    init(ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService,
         bookService: BookServiceProtocol = AppDependencies.shared.bookService,
         wordService: WordServiceProtocol = AppDependencies.shared.wordService) {
        self.ruleService = ruleService
        self.bookService = bookService
        self.wordService = wordService
    }
    
    // MARK: - Methods
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
        ruleService.getRules(activeOnly: true) { [weak self] rulesResult in
            guard let self = self else { return }
            switch rulesResult {
            case .success(let activeRules):
                self.activeRules = activeRules
                self.getBooksWithWords { booksWithWordsResult in
                    switch booksWithWordsResult {
                    case .success(let booksWithWords):
                        print("BOOKS WITH WORDS: \(booksWithWords)")
                        completion(.success(activeRules))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getBooksWithWords(_ completion: @escaping (Result<[String: [String]], Error>) -> Void) {
        bookService.getBooks { [weak self] booksResult in
            guard let self = self else { return }
            switch booksResult {
            case .success(let books):
                books.forEach { book in
                    self.wordService.getWords(for: book) { [weak self] wordsResult in
                        guard let self = self else { return }
                        switch wordsResult {
                        case .success(let words):
                            guard let bookName = book.name else { return }
                            self.activeBooksWithWords[bookName] = words.compactMap { $0.title }
                            completion(.success(activeBooksWithWords))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func generate(_ completion: @escaping (Result<String, Error>) -> Void) {
        guard let randomRuleName = self.activeRules.randomElement()?.name else {
            completion(.success(""))
            return
        }
        print("Random selected rule: \(randomRuleName)")

        let bookNames = randomRuleName.components(separatedBy: " ")
        print("Book names in rule: \(bookNames)")

        self.generatedStr = bookNames.compactMap { activeBooksWithWords[$0]?.randomElement() }
            .joined(separator: " ")
        completion(.success(self.generatedStr))
    }
    
}
