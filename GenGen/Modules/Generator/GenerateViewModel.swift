//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol Generating {
    var generatedStr: String { get }
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void)
    func generate(_ completion: @escaping (Result<String, Error>) -> Void)
    func addFavorite(_ text: String, completion: @escaping (Result<Void, Error>) -> Void)

}

// MARK: - Generator
class GenerateViewModel: Generating {

    // MARK: - Properties
    var generatedStr: String = ""
    var activeRules: [Rule] = []

    let getActiveRulesUseCase: GetActiveRulesUseCaseProtocol
    let getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol
    let getWordsInBookUseCase: GetWordsInBookUseCaseProtocol
    private let addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol

    // MARK: - Initialization
    init(
        getActiveRulesUseCase: GetActiveRulesUseCaseProtocol = GetActiveRulesUseCase(),
        getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol = GetBookIDsInRuleUseCase(),
        getWordsInBookUseCase: GetWordsInBookUseCaseProtocol = GetWordsInBookUseCase(),
        addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol = AddFavoriteIfNotExistsUseCase()
    ) {
        self.getActiveRulesUseCase = getActiveRulesUseCase
        self.getBookIDsInRuleUseCase = getBookIDsInRuleUseCase
        self.getWordsInBookUseCase = getWordsInBookUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
    }

    // MARK: - Methods
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
        getActiveRulesUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let activeRules):
                self.activeRules = activeRules
                completion(.success(activeRules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func generate(_ completion: @escaping (Result<String, Error>) -> Void) {
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
                    self.generatedStr = generatedWords.joined(separator: " ")
                    completion(.success(self.generatedStr))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addFavorite(_ text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        addFavoriteUseCase.execute(favoriteTitle: text) { result in
            switch result {
            case .success(let favorite):
                if favorite != nil {
                    print("Favorite added successfully")
                } else {
                    print("Favorite already exists")
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
