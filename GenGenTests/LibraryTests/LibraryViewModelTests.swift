//
//  LibraryViewModelTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import XCTest
@testable import GenGen

final class LibraryViewModelTests: XCTestCase {

    func test_fetchBooks_WithNoBooks_returnsNoBooks() throws {
        let sut = LibraryViewModel()

        let books = sut.fetchBooks()

        XCTAssertEqual(books.count, 0)
    }

    func test_addBook_Succeeds() throws {
        let bookToAdd = Book(name: "size", words: ["giant"])
        let sut = LibraryViewModel()

        let booksBeforeAdding = sut.fetchBooks()
        XCTAssertEqual(booksBeforeAdding.count, 0)
        sut.addBook(book: bookToAdd)
        let booksAfterAdding = sut.fetchBooks()

        XCTAssertEqual(booksAfterAdding.count, 1)

    }
}
