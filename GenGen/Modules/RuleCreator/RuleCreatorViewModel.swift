//
//  RuleCreatorViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit
import CoreData

protocol RuleCreatorViewModelProtocol {
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)

}

class RuleCreatorViewModel: RuleCreatorViewModelProtocol {

    // MARK: - Dependencies
    let bookService: BookServiceProtocol
    private var books: [Book]

    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService, books: [Book] = []) {
        self.bookService = bookService
        self.books = books
    }

    // MARK: - Methods
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        bookService.getBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
