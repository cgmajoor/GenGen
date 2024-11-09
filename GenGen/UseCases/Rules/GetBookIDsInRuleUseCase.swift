//
//  GetBookIDsInRuleUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 08/11/2024.
//

import Foundation

protocol GetBookIDsInRuleUseCaseProtocol {
    func execute(rule: Rule, completion: @escaping (Result<[UUID], Error>) -> Void)
}

class GetBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol {
    func execute(rule: Rule, completion: @escaping (Result<[UUID], Error>) -> Void) {
        guard let bookIDs = rule.bookIDs as? [UUID] else {
            completion(.failure(NSError(domain: "Invalid Book IDs", code: 0, userInfo: nil)))
            return
        }
        completion(.success(bookIDs))
    }
}
