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
}
