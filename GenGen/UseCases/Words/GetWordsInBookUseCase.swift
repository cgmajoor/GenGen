//
//  GetWordsInBookUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 08/11/2024.
//

import Foundation

protocol GetWordsInBookUseCaseProtocol {
    func execute(bookID: UUID, completion: @escaping (Result<[String], Error>) -> Void)
}

class GetWordsInBookUseCase: GetWordsInBookUseCaseProtocol {
    private let wordService: WordServiceProtocol
    
    init(wordService: WordServiceProtocol = AppDependencies.shared.wordService) {
        self.wordService = wordService
    }
    
    func execute(bookID: UUID, completion: @escaping (Result<[String], Error>) -> Void) {
        wordService.getWords(forBookID: bookID) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let words):
                completion(.success(words.compactMap { $0.title }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
