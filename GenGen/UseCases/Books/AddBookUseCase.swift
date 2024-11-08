//
//  AddBookUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

protocol AddBookUseCaseProtocol {
    func execute(bookName: String, completion: @escaping (Result<[Book], Error>) -> Void)
}

class AddBookUseCase: AddBookUseCaseProtocol {
    private let bookService: BookServiceProtocol
    private let doesBookExistUseCase: DoesBookExistUseCaseProtocol
    private let getAllBooksUseCase: GetAllBooksUseCaseProtocol
    
    init(bookService: BookServiceProtocol = AppDependencies.shared.bookService,
         doesBookExistUseCase: DoesBookExistUseCaseProtocol = DoesBookExistUseCase(),
         getAllBooksUseCase: GetAllBooksUseCaseProtocol = GetAllBooksUseCase()) {
        self.bookService = bookService
        self.doesBookExistUseCase = doesBookExistUseCase
        self.getAllBooksUseCase = getAllBooksUseCase
    }
    
    func execute(bookName: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        doesBookExistUseCase.execute(bookName: bookName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let doesExist):
                if doesExist {
                    print("Book with name '\(bookName)' already exists.")
                    self.getAllBooksUseCase.execute(completion)
                } else {
                    self.bookService.addBook(bookName) { [weak self] addResult in
                        guard let self = self else { return }
                        switch addResult {
                        case .success:
                            self.getAllBooksUseCase.execute(completion)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
