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
        let sanitizedBookName = bookName.sanitizedForDatabase()
        
        doesBookExistUseCase.execute(bookName: sanitizedBookName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let doesExist):
                if doesExist {
                    // Fetch and return all books if a duplicate is found
                    print("Book with name '\(sanitizedBookName)' already exists.")
                    self.getAllBooksUseCase.execute(completion)
                } else {
                    self.bookService.addBook(sanitizedBookName) { [weak self] addResult in
                        guard let self = self else { return }
                        switch addResult {
                        case .success:
                            // Reload books after adding a new one
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
