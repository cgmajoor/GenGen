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
        getAllBooksUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                let doesExist = books.contains { $0.name == bookName }
                completion(.success(doesExist))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
