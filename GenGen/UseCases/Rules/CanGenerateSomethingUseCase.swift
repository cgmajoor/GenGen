//
//  CanGenerateSomethingUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol CanGenerateSomethingUseCaseProtocol {
    func execute(completion: @escaping (Result<Bool, Error>) -> Void)
}

class CanGenerateSomethingUseCase: CanGenerateSomethingUseCaseProtocol {
    private let getActiveRulesUseCase: GetActiveRulesUseCaseProtocol
    private let getWordsInBookUseCase: GetWordsInBookUseCaseProtocol

    init(
        getActiveRulesUseCase: GetActiveRulesUseCaseProtocol = GetActiveRulesUseCase(),
        getWordsInBookUseCase: GetWordsInBookUseCaseProtocol = GetWordsInBookUseCase()
    ) {
        self.getActiveRulesUseCase = getActiveRulesUseCase
        self.getWordsInBookUseCase = getWordsInBookUseCase
    }

    func execute(completion: @escaping (Result<Bool, Error>) -> Void) {
        getActiveRulesUseCase.execute { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let activeRules):
                guard !activeRules.isEmpty else {
                    completion(.success(false))
                    return
                }

                let dispatchGroup = DispatchGroup()
                var canGenerate = false

                for rule in activeRules {
                    guard let bookIDs = rule.bookIDs as? [UUID] else { continue }

                    for bookId in bookIDs {
                        dispatchGroup.enter()

                        self.getWordsInBookUseCase.execute(bookID: bookId) { wordResult in
                            defer { dispatchGroup.leave() }

                            switch wordResult {
                            case .success(let words) where !words.isEmpty:
                                canGenerate = true
                            case .failure(let error):
                                print("Error fetching words for book: \(error)")
                            default:
                                break
                            }
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(.success(canGenerate))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
