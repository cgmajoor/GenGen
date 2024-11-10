//
//  RuleCreatorViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit
import CoreData

protocol RuleCreatorViewModelProtocol {
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)
    func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Rule, Error>) -> Void)
}

class RuleCreatorViewModel: RuleCreatorViewModelProtocol {

    // MARK: - Dependencies
    let bookService: BookServiceProtocol
    let ruleService: RuleServiceProtocol
    private var books: [Book]
    private var rules: [Rule]

    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService,
         ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService,
         books: [Book] = [],
         rules: [Rule] = []) {
        self.bookService = bookService
        self.ruleService = ruleService
        self.books = books
        self.rules = rules
    }

    // MARK: - Methods
    func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Rule, Error>) -> Void) {
        self.canAddRule(with: ruleName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let canAddRule):
                if canAddRule {
                    self.ruleService.addRule(ruleName, books: books, isActive: isActive) { result in
                        switch result {
                        case .success(let rule):
                            completion(.success(rule))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.failure(RuleError.ruleAlreadyExists))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        bookService.getBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Methods
    private func fetchRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
        ruleService.getRules(activeOnly: false) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rules):
                self.rules = rules
                completion(.success(rules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func canAddRule(with ruleName: String, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        self.fetchRules() { result in
            switch result {
            case .success(let rules):
                let doesRuleExist = rules.contains(where: { $0.name == ruleName })
                completion(.success(!doesRuleExist))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
