//
//  LibraryViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import Foundation

protocol BookProvider {
    func fetchBooks() -> [Book]
    func addBook(bookName: String?) -> Bool
}

class LibraryViewModel: BookProvider {

    // MARK: - Properties
    private var books: [Book] = []

    // MARK: - Methods
    func fetchBooks() -> [Book] {
        //TODO: Fetch from somewhere currently testing
        return books
    }

    func addBook(bookName: String?) -> Bool {
        guard let bookName = bookName else {
            return false
        }
        let book = Book(name: bookName, words: [])
        books.append(book)
        return true
    }
}
