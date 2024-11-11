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
    func updateRule(_ rule: Rule, _ completion: @escaping (Result<Rule, Error>) -> Void)
    func deleteRule(_ rule: Rule, completion: @escaping (Result<Void, Error>) -> Void)
}

class RulesViewModel: RuleProvider {
    
    // MARK: - Properties
    let ruleService: RuleServiceProtocol
    private var rules: [Rule]

    // MARK: - Initialization
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
    
    func updateRule(_ rule: Rule, _ completion: @escaping (Result<Rule, Error>) -> Void) {
        guard let isUpdated = self.ruleService.update(rule) else {
            completion(.failure(NSError()))
            return
        }
        completion(.success(isUpdated))
    }
    
    func deleteRule(_ rule: Rule, completion: @escaping (Result<Void, Error>) -> Void) {
        ruleService.deleteRule(rule) { result in
            switch result {
            case .success:
                if let index = self.rules.firstIndex(of: rule) {
                    self.rules.remove(at: index)
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
