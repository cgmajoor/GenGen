//
//  AddWordToBookUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import Foundation

protocol AddWordToBookUseCaseProtocol {
    func execute(word: String, book: Book, completion: @escaping (Result<(Book, Word), any Error>) -> Void)
}

class AddWordToBookUseCase: AddWordToBookUseCaseProtocol {
    private let wordService: WordServiceProtocol
    
    init(wordService: WordServiceProtocol = AppDependencies.shared.wordService) {
        self.wordService = wordService
    }
    
    func execute(word: String, book: Book, completion: @escaping (Result<(Book, Word), any Error>) -> Void) {
        wordService.addWord(word, to: book, completion)
    }
}
