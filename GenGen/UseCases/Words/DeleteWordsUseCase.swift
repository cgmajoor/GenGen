//
//  DeleteWordsUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

import Foundation

protocol DeleteWordUseCaseProtocol {
    func execute(word: Word, completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteWordUseCase: DeleteWordUseCaseProtocol {
    private let wordService: WordServiceProtocol

    init(wordService: WordServiceProtocol = AppDependencies.shared.wordService) {
        self.wordService = wordService
    }

    func execute(word: Word, completion: @escaping (Result<Void, Error>) -> Void) {
        wordService.deleteWord(word, completion: completion)
    }
}
