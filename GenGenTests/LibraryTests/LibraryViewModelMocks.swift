//
//  LibraryViewModelMocks.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import Foundation
@testable import GenGen

class MockLibraryViewModel: LibraryViewModel {
    let noBooks = [Book]()

    override func fetchBooks() -> [Book] {
        return noBooks
    }
}

class MockLibraryViewModelWithOneBook: LibraryViewModel {
    let oneBook = [Book(name: "color", words: [])]

    override func fetchBooks() -> [Book] {
        return oneBook
    }
}

class MockLibraryViewModelWithTwoBooks: LibraryViewModel {
    let twoBooks = [Book(name: "color", words: []), Book(name: "animal", words: [])]

    override func fetchBooks() -> [Book] {
        return twoBooks
    }
}
