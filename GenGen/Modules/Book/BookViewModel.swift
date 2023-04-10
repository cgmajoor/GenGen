//
//  BookViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 04/04/2023.
//

import UIKit
import CoreData

protocol BookViewModelProtocol {
    func fetchWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void)
    func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void)
}

class BookViewModel: BookViewModelProtocol {

    // MARK: - Properties
    let wordService: WordServiceProtocol
    private var book: Book?
    private var words: [Word]

    init(wordService: WordServiceProtocol = AppDependencies.shared.wordService, book: Book? = nil, words: [Word] = []) {
        self.wordService = wordService
        self.book = book
        self.words = words
    }
    
    // MARK: - Methods
    func fetchWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void) {
        wordService.getWords(for: book) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let words):
                self.words = words
                completion(.success(words))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void) {
        if !doesWordExist(with: wordTitle) {
            wordService.addWord(wordTitle, to: book) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success((let book, let word)):
                    self.words.append(word)
                    self.book = book
                    completion(.success((book, self.words)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    private func doesWordExist(with wordTitle: String) -> Bool {
        return words.contains(where: { $0.title == wordTitle })
    }
}
