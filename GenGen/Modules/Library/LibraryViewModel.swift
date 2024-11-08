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
    func deleteBookWithDependencies(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void)
}

class LibraryViewModel: LibraryViewModelProtocol {

    // MARK: - Use Cases
    private let getAllBooksUseCase: GetAllBooksUseCaseProtocol
    private let addBookUseCase: AddBookUseCaseProtocol
    private let deleteBookWithDependenciesUseCase: DeleteBookWithDependenciesUseCaseProtocol
    private let deleteBookUseCase: DeleteBookUseCaseProtocol

    private var books: [Book] = []

    // MARK: - Initialization
    init(
        getAllBooksUseCase: GetAllBooksUseCaseProtocol = GetAllBooksUseCase(),
        addBookUseCase: AddBookUseCaseProtocol = AddBookUseCase(),
        deleteBookWithDependenciesUseCase: DeleteBookWithDependenciesUseCaseProtocol = DeleteBookWithDependenciesUseCase(),
        deleteBookUseCase: DeleteBookUseCaseProtocol = DeleteBookUseCase()
    ) {
        self.getAllBooksUseCase = getAllBooksUseCase
        self.addBookUseCase = addBookUseCase
        self.deleteBookWithDependenciesUseCase = deleteBookWithDependenciesUseCase
        self.deleteBookUseCase = deleteBookUseCase
    }

    // MARK: - Methods
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        getAllBooksUseCase.execute { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addBook(bookName: String, _ completion: @escaping (Result<[Book], Error>) -> Void) {
        addBookUseCase.execute(bookName: bookName, completion: completion)
    }

    func deleteBookWithDependencies(_ book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        deleteBookWithDependenciesUseCase.execute(book: book, completion)
    }
}
