//
//  GetAllRules.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol GetAllRulesUseCaseProtocol {
    func execute(completion: @escaping (Result<[Rule], Error>) -> Void)
}

class GetAllRulesUseCase: GetAllRulesUseCaseProtocol {
    private let ruleService: RuleServiceProtocol

    init(ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService) {
        self.ruleService = ruleService
    }

    func execute(completion: @escaping (Result<[Rule], Error>) -> Void) {
        ruleService.getRules(activeOnly: false, completion)
    }
}
