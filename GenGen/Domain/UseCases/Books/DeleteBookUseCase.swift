//
//  DeleteBookUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

protocol DeleteBookUseCaseProtocol {
    func execute(book: Book, _ completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteBookUseCase: DeleteBookUseCaseProtocol {
    private let bookService: BookServiceProtocol
    
    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService) {
        self.bookService = bookService
    }
    
    func execute(book: Book, _ completion: @escaping (Result<Void, Error>) -> Void) {
        bookService.deleteBook(book, completion)
    }
}
