//
//  LibraryViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import UIKit
import CoreData

protocol LibraryViewModelProtocol {
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)
    func addBook(bookName: String, _ completion: @escaping (Result<[Book], Error>) -> Void)
    func deleteBook(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteBookWithDependencies(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void)
}

class LibraryViewModel: LibraryViewModelProtocol {
    
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
    
    func addBook(bookName: String, _ completion: @escaping (Result<[Book], Error>) -> Void) {
        if !doesBookExist(with: bookName) {
            bookService.addBook(bookName) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let book):
                    self.books.append(book)
                    completion(.success(self.books))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func deleteBook(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        bookService.deleteBook(book) { [weak self] result in
            switch result {
            case .success:
                if let index = self?.books.firstIndex(of: book) {
                    self?.books.remove(at: index)
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    private func doesBookExist(with bookName: String) -> Bool {
        return books.contains(where: { $0.name == bookName })
    }
    
    // In LibraryViewModel.swift
    func deleteBookWithDependencies(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        bookService.deleteBookWithDependencies(book) { result in
            switch result {
            case .success:
                if let index = self.books.firstIndex(of: book) {
                    self.books.remove(at: index)
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
