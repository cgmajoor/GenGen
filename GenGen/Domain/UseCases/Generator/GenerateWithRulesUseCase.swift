//
//  GenerateWithRulesUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

import Foundation

protocol GenerateWithRulesUseCaseProtocol {
    func execute(activeRules: [Rule], completion: @escaping (Result<String, Error>) -> Void)
}

class GenerateWithRulesUseCase: GenerateWithRulesUseCaseProtocol {
    private let getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol
    private let getWordsInBookUseCase: GetWordsInBookUseCaseProtocol

    init(
        getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol = GetBookIDsInRuleUseCase(),
        getWordsInBookUseCase: GetWordsInBookUseCaseProtocol = GetWordsInBookUseCase()
    ) {
        self.getBookIDsInRuleUseCase = getBookIDsInRuleUseCase
        self.getWordsInBookUseCase = getWordsInBookUseCase
    }

    func execute(activeRules: [Rule], completion: @escaping (Result<String, Error>) -> Void) {
        guard let randomRule = activeRules.randomElement() else {
            completion(.success(""))
            return
        }

        getBookIDsInRuleUseCase.execute(rule: randomRule) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookIDs):
                var generatedWords: [String] = []
                let dispatchGroup = DispatchGroup()

                for bookID in bookIDs {
                    dispatchGroup.enter()
                    self.getWordsInBookUseCase.execute(bookID: bookID) { wordResult in
                        switch wordResult {
                        case .success(let words):
                            if let randomWord = words.randomElement() {
                                generatedWords.append(randomWord)
                            }
                        case .failure(let error):
                            print("Failed to get words for bookID \(bookID): \(error)")
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    let generatedText = generatedWords.joined(separator: " ")
                    completion(.success(generatedText))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
