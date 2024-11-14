//
//  DoesWordExistUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol DoesWordExistUseCaseProtocol {
    func execute(wordTitle: String, book: Book, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DoesWordExistUseCase: DoesWordExistUseCaseProtocol {
    private let getWordsInBookUseCase: GetWordsInBookUseCaseProtocol

    init(getWordsInBookUseCase: GetWordsInBookUseCaseProtocol = GetWordsInBookUseCase()) {
        self.getWordsInBookUseCase = getWordsInBookUseCase
    }

    func execute(wordTitle: String, book: Book, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let bookID = book.id else {
            completion(.failure(NSError(domain: "Invalid Book ID", code: 500, userInfo: nil)))
            return
        }
        
        getWordsInBookUseCase.execute(bookID: bookID) { result in
            switch result {
            case .success(let words):
                let exists = words.contains { $0 == wordTitle }
                completion(.success(exists))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
