//
//  BookServiceTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class BookServiceTests: XCTestCase {

    func test_addBook_succeeds() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testBookService = BookService(coreDataStack: testCoreDataStack)
        let bookName = "color"
        let expectation = expectation(description: "Expected add book to succeed")
        testBookService.addBook(bookName) { result in
            switch result {
            case .success(let book):
                XCTAssertEqual(book.name, bookName)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_getBooks_givenNoBooks_returnsNoBooks() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testBookService = BookService(coreDataStack: testCoreDataStack)

        let expectation = expectation(description: "Expected no books")
        testBookService.getBooks { result in
            switch result {
            case .success(let books):
                XCTAssertTrue(books.isEmpty)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_getBooks_given1Book_returns1BookCorrectly() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testBookService = BookService(coreDataStack: testCoreDataStack)

        let bookName = "color"

        let expectation = expectation(description: "Expected no books")

        testBookService.addBook(bookName) { result in
            testBookService.getBooks { result in
                switch result {
                case .success(let books):
                    XCTAssertEqual(books.count, 1)
                    XCTAssertEqual(books.first?.name, bookName)
                    expectation.fulfill()
                case .failure(let failure):
                    XCTFail("\(failure)")
                }
            }

        }

        waitForExpectations(timeout: 2.0)
    }

}
