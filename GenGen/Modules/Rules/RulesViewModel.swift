//
//  RulesViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit
import CoreData

protocol RuleProvider {
    func fetchRules(_ completion: @escaping (Result<[Rule], Error>) -> Void)
}

class RulesViewModel: RuleProvider {

    // MARK: - Properties
    let ruleService: RuleServiceProtocol
    private var rules: [Rule]

    init(ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService, rules: [Rule] = []) {
        self.ruleService = ruleService
        self.rules = rules
    }

    // MARK: - Methods
    func fetchRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
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

}
