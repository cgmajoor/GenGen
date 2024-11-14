//
//  GetActiveRulesUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 08/11/2024.
//

import Foundation

protocol GetActiveRulesUseCaseProtocol {
    func execute(completion: @escaping (Result<[Rule], Error>) -> Void)
}

class GetActiveRulesUseCase: GetActiveRulesUseCaseProtocol {
    private let ruleService: RuleServiceProtocol

    init(ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService) {
        self.ruleService = ruleService
    }

    func execute(completion: @escaping (Result<[Rule], Error>) -> Void) {
        ruleService.getRules(activeOnly: true, completion)
    }
}
