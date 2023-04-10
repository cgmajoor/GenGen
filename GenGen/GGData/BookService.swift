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
}

public class BookService: BookServiceProtocol {
    // MARK: - Properties
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext

    // MARK: - Initialization
    public init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
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
}
