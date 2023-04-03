//
//  LibraryViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import Foundation

protocol BookProvider {
    func fetchBooks() -> [Book]
}

class LibraryViewModel: BookProvider {

    // MARK: - Properties
    private var books: [Book] = []

    // MARK: - Methods
    func fetchBooks() -> [Book] {
        //TODO: Fetch from somewhere currently testing
//        books = [Book(name: "color", words: ["pink"]),
//                 Book(name: "animal", words: ["panda"])]
        return books
    }
}
