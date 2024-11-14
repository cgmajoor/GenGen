//
//  GetAllBooksUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

protocol GetAllBooksUseCaseProtocol {
    func execute(_ completion: @escaping (Result<[Book], Error>) -> Void)
}

class GetAllBooksUseCase: GetAllBooksUseCaseProtocol {
    private let bookService: BookServiceProtocol
    
    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService) {
        self.bookService = bookService
    }
    
    func execute(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        bookService.getBooks(completion)
    }
}
