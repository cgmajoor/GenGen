//
//  DeleteBookWithDependenciesUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

protocol DeleteBookWithDependenciesUseCaseProtocol {
    func execute(book: Book, _ completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteBookWithDependenciesUseCase: DeleteBookWithDependenciesUseCaseProtocol {
    private let bookService: BookServiceProtocol
    
    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService) {
        self.bookService = bookService
    }
    
    func execute(book: Book, _ completion: @escaping (Result<Void, Error>) -> Void) {
        bookService.deleteBookWithDependencies(book, completion)
    }
}
