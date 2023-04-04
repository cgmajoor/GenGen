//
//  LibraryViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import UIKit
import CoreData

protocol BookProvider {
    func getBooks(_ completion: @escaping (Result<[Book], Error>) -> Void)
    func addBook(bookName: String) -> Bool
}

class LibraryViewModel: BookProvider {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Properties
    private var books: [Book] = []

    // MARK: - Methods
    func getBooks(_ completion: @escaping (Result<[Book], Error>) -> Void) {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            books = try context.fetch(request)
            completion(.success(books))
        } catch {
            completion(.failure(error))
        }
    }

    func addBook(bookName: String) -> Bool {
        let newBook = Book(context: context)
        newBook.name = bookName
        books.append(newBook)
        do {
            try context.save()
        } catch {
            print("Error adding book")
        }
        return true
    }
}
