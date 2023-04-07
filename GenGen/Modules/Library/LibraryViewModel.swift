//
//  LibraryViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import UIKit
import CoreData

protocol BookProvider {
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)
    func addBook(bookName: String, _ completion: @escaping (Result<[Book], Error>) -> Void)
}

class LibraryViewModel: BookProvider {

    // MARK: - Dependencies
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    private var books: [Book]

    init(coreDataStack: CoreDataStack = CoreDataStack(), books: [Book] = []) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
        self.books = books
    }

    // MARK: - Methods
    func fetchBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            books = try context.fetch(request)
            completion(.success(books))
        } catch {
            completion(.failure(error))
        }
    }

    func addBook(bookName: String, _ completion: @escaping (Result<[Book], Error>) -> Void) {
        let newBook = Book(context: context)
        newBook.name = bookName
        books.append(newBook)
        do {
            try context.save()
            completion(.success(books))
        } catch {
            completion(.failure(error))
        }
    }
}
