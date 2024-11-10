//
//  PrepopulateDatabaseUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol PrepopulateDatabaseUseCaseProtocol {
    func execute(completion: @escaping (Result<Void, Error>) -> Void)
}

class PrepopulateDatabaseUseCase: PrepopulateDatabaseUseCaseProtocol {
    private let addBookUseCase: AddBookUseCaseProtocol
    private let wordService: WordServiceProtocol
    private let ruleService: RuleServiceProtocol
    private let doesRuleExistUseCase: DoesRuleExistUseCaseProtocol
    private let getAllBooksUseCase: GetAllBooksUseCaseProtocol

    init(
        addBookUseCase: AddBookUseCaseProtocol = AddBookUseCase(),
        wordService: WordServiceProtocol = AppDependencies.shared.wordService,
        ruleService: RuleServiceProtocol = AppDependencies.shared.ruleService,
        doesRuleExistUseCase: DoesRuleExistUseCaseProtocol = DoesRuleExistUseCase(),
        getAllBooksUseCase: GetAllBooksUseCaseProtocol = GetAllBooksUseCase()
    ) {
        self.addBookUseCase = addBookUseCase
        self.wordService = wordService
        self.ruleService = ruleService
        self.doesRuleExistUseCase = doesRuleExistUseCase
        self.getAllBooksUseCase = getAllBooksUseCase
    }

    func execute(completion: @escaping (Result<Void, Error>) -> Void) {
        getAllBooksUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let existingBooks):
                let booksAndWords = [
                    ("size", Texts.PrepopulationData.sizes),
                    ("color", Texts.PrepopulationData.colors),
                    ("animal", Texts.PrepopulationData.animals),
                    ("food", Texts.PrepopulationData.foods),
                    ("characteristic", Texts.PrepopulationData.characteristics),
                    ("action", Texts.PrepopulationData.actions),
                    ("number", Texts.PrepopulationData.numbers),
                    ("capital", Texts.PrepopulationData.capitals),
                    ("lowercase", Texts.PrepopulationData.lowercases),
                    ("company", Texts.PrepopulationData.company),
                    ("person", Texts.PrepopulationData.persons),
                    ("thing", Texts.PrepopulationData.things),
                    ("place", Texts.PrepopulationData.places)
                ]

                self.performPrepopulation(with: booksAndWords, existingBooks: existingBooks, completion: completion)

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func performPrepopulation(with booksAndWords: [(String, [String])], existingBooks: [Book], completion: @escaping (Result<Void, Error>) -> Void) {
        var addedBooks: [Book] = []
        let dispatchGroup = DispatchGroup()

        for (bookName, words) in booksAndWords {
            if let existingBook = existingBooks.first(where: { $0.name == bookName }) {
                addedBooks.append(existingBook)
            } else {
                dispatchGroup.enter()
                addBookUseCase.execute(bookName: bookName) { result in
                    switch result {
                    case .success(let books):
                        if let newBook = books.first(where: { $0.name == bookName }) {
                            addedBooks.append(newBook)
                            self.addWordsIfNeeded(words, to: newBook, completion: completion)
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.addRules(using: addedBooks, completion: completion)
        }
    }

    private func addWordsIfNeeded(_ words: [String], to book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        let dispatchGroup = DispatchGroup()

        for word in words {
            dispatchGroup.enter()
            wordService.getWords(for: book) { result in
                switch result {
                case .success(let existingWords):
                    if !existingWords.contains(where: { $0.title == word }) {
                        self.wordService.addWord(word, to: book) { _ in
                            dispatchGroup.leave()
                        }
                    } else {
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(()))
        }
    }

    private func addRules(using books: [Book], completion: @escaping (Result<Void, Error>) -> Void) {
        guard
            let size = books.first(where: { $0.name == "size" }),
            let color = books.first(where: { $0.name == "color" }),
            let animal = books.first(where: { $0.name == "animal" }),
            let food = books.first(where: { $0.name == "food" }),
            let characteristic = books.first(where: { $0.name == "characteristic" }),
            let action = books.first(where: { $0.name == "action" }),
            let number = books.first(where: { $0.name == "number" }),
            let capital = books.first(where: { $0.name == "capital" }),
            let lowercase = books.first(where: { $0.name == "lowercase" }),
            let company = books.first(where: { $0.name == "company" }),
            let person = books.first(where: { $0.name == "person" }),
            let thing = books.first(where: { $0.name == "thing" }),
            let place = books.first(where: { $0.name == "place" })
        else {
            completion(.failure(NSError(domain: "Books not found", code: 404, userInfo: nil)))
            return
        }

        let rules = [
            ("size color food", [size, color, food]),
            ("size characteristic animal", [size, characteristic, animal]),
            ("action thing", [action, thing]),
            ("action size animal", [action, size, animal]),
            ("lowercase capital number", [lowercase, capital, number]),
            ("characteristic animal company", [characteristic, animal, company]),
            ("size thing place", [size, thing, place]),
            ("place person", [place, person]),
            ("place thing", [place, thing]),
            ("place animal", [place, animal])
        ]

        let dispatchGroup = DispatchGroup()

        for (ruleName, ruleBooks) in rules {
            dispatchGroup.enter()
            doesRuleExistUseCase.execute(ruleName: ruleName, books: ruleBooks) { result in
                switch result {
                case .success(let ruleExists):
                    if !ruleExists {
                        self.ruleService.addRule(ruleName, books: ruleBooks, isActive: true) { _ in
                            dispatchGroup.leave()
                        }
                    } else {
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(()))
        }
    }
}
