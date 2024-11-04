//
//  BookService.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import Foundation
import CoreData

protocol BookServiceProtocol {
    func addBook(_ bookName: String, _ completion: @escaping (Result<Book, Error>) -> Void)
    func getBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)
    func deleteBook(_ book: Book, _ completion: @escaping (Result<Void, Error>) -> Void)
    func deleteBookWithDependencies(_ book: Book, _ completion: @escaping (Result<Void, Error>) -> Void)
}

public class BookService: BookServiceProtocol {
    // MARK: - Properties
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    private let ruleService: RuleServiceProtocol
    private let wordService: WordServiceProtocol
    
    // MARK: - Initialization
    public init(coreDataStack: CoreDataStack = CoreDataStack(),
                ruleService: RuleServiceProtocol,
                wordService: WordServiceProtocol) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
        self.ruleService = ruleService
        self.wordService = wordService
    }
}

extension BookService {
    public func addBook(_ bookName: String, _ completion: @escaping (Result<Book, Error>) -> Void) {
        let book = Book(context: context)
        book.name = bookName
        do {
            try coreDataStack.saveContext()
            completion(.success(book))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func getBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try context.fetch(request)
            completion(.success(books))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func deleteBook(_ book: Book, _ completion: @escaping (Result<Void, Error>) -> Void) {
        context.delete(book)
        do {
            try coreDataStack.saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func deleteBookWithDependencies(_ book: Book, _ completion: @escaping (Result<Void, Error>) -> Void) {
        ruleService.deleteAllRulesContaining(book: book) { [weak self] ruleResult in
            switch ruleResult {
            case .success:
                self?.wordService.deleteAllWords(in: book) { wordResult in
                    switch wordResult {
                    case .success:
                        self?.context.delete(book)
                        do {
                            try self?.coreDataStack.saveContext()
                            completion(.success(()))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
