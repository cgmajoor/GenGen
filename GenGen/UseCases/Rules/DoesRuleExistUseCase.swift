//
//  DoesRuleExistUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol DoesRuleExistUseCaseProtocol {
    func execute(ruleName: String, books: [Book], completion: @escaping (Result<Bool, Error>) -> Void)
}

class DoesRuleExistUseCase: DoesRuleExistUseCaseProtocol {
    private let getAllRulesUseCase: GetAllRulesUseCaseProtocol
    private let bookService: BookServiceProtocol

    init(
        getAllRulesUseCase: GetAllRulesUseCaseProtocol = GetAllRulesUseCase(),
        bookService: BookServiceProtocol = AppDependencies.shared.bookService
    ) {
        self.getAllRulesUseCase = getAllRulesUseCase
        self.bookService = bookService
    }

    func execute(ruleName: String, books: [Book], completion: @escaping (Result<Bool, Error>) -> Void) {
        getAllRulesUseCase.execute() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let existingRules):
                let bookIDs = Set(books.compactMap { $0.id })

                let ruleExists = existingRules.contains { existingRule in
                    guard existingRule.name == ruleName else { return false }

                    guard let existingBookIDs = existingRule.bookIDs as? [UUID] else { return false }

                    return Set(existingBookIDs) == bookIDs
                }

                completion(.success(ruleExists))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}