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
    func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Void, Error>) -> Void)
}

class RuleCreatorViewModel: RuleCreatorViewModelProtocol {
    
    // MARK: - Dependencies
    let getAllBooksUseCase: GetAllBooksUseCaseProtocol
    let addRuleUseCase: AddRuleUseCaseProtocol
    
    // MARK: - Properties
    private var books: [Book]
    
    // MARK: - Initialization
    init(
        getAllBooksUseCase: GetAllBooksUseCaseProtocol = GetAllBooksUseCase(),
        addRuleUseCase: AddRuleUseCaseProtocol = AddRuleUseCase(),
        books: [Book] = []
    ) {
        self.getAllBooksUseCase = getAllBooksUseCase
        self.addRuleUseCase = addRuleUseCase
        self.books = books
    }
    
    // MARK: - Methods
    func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        self.addRuleUseCase.execute(ruleName: ruleName, books: books, isActive: isActive){ result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        getAllBooksUseCase.execute() { [weak self] result in
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
