//
//  DoesBookExistUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

protocol DoesBookExistUseCaseProtocol {
    func execute(bookName: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class DoesBookExistUseCase: DoesBookExistUseCaseProtocol {
    private let getAllBooksUseCase: GetAllBooksUseCaseProtocol
    
    init(getAllBooksUseCase: GetAllBooksUseCaseProtocol = GetAllBooksUseCase()) {
        self.getAllBooksUseCase = getAllBooksUseCase
    }
    
    func execute(bookName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let sanitizedBookName = bookName.sanitizedForDatabase()
        
        getAllBooksUseCase.execute { result in
            switch result {
            case .success(let books):
                let doesExist = books.contains { $0.name == sanitizedBookName }
                completion(.success(doesExist))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
