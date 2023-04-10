//
//  LibraryViewModelTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 02/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class LibraryViewModelTests: XCTestCase {

    func test_fetchBooks_WithNoBooks_returnsNoBooks() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testBookService = BookService(coreDataStack: testCoreDataStack)
        let sut = LibraryViewModel(bookService: testBookService)

        let expectation = expectation(description: "Given no books fetchBooks should return no books")

        sut.fetchBooks { result in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 0)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_addBook_Succeeds() throws {
        let bookName = "size"
        let testCoreDataStack = TestCoreDataStack()
        let testBookService = BookService(coreDataStack: testCoreDataStack)
        let sut = LibraryViewModel(bookService: testBookService)

        let booksBeforeAdding = expectation(description: "Before adding a book, fetchBooks return no books")

        sut.fetchBooks { result in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 0)
                booksBeforeAdding.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)

        let booksAfterAdding = expectation(description: "After adding a book, fetchBooks return 1 book")
        sut.addBook(bookName: bookName) { result in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 1)
                booksAfterAdding.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }
}
