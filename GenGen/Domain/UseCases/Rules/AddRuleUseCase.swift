//
//  AddRuleUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol AddRuleUseCaseProtocol {
    func execute(ruleName: String, books: [Book], isActive: Bool, completion: @escaping (Result<Void, Error>) -> Void)
}

class AddRuleUseCase: AddRuleUseCaseProtocol {
    private let ruleService: RuleServiceProtocol
    private let doesRuleExistUseCase: DoesRuleExistUseCaseProtocol

    init(
        ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService,
        doesRuleExistUseCase: DoesRuleExistUseCaseProtocol = DoesRuleExistUseCase()
    ) {
        self.ruleService = ruleService
        self.doesRuleExistUseCase = doesRuleExistUseCase
    }

    func execute(ruleName: String, books: [Book], isActive: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        doesRuleExistUseCase.execute(ruleName: ruleName, books: books) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let ruleExists):
                if ruleExists {
                    completion(.failure(RuleError.ruleAlreadyExists))
                } else {
                    self.ruleService.addRule(ruleName, books: books, isActive: isActive) { addRuleResult in
                        switch addRuleResult {
                        case .success:
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

