//
//  BookViewModelTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 08/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class BookViewModelTests: XCTestCase {

    func test_fetchBook_completesSuccessfully() throws {
        let testCoreDataStack = TestCoreDataStack()
        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let bookName = "color"
        colorBook.name = bookName
        let sut = BookViewModel(coreDataStack: testCoreDataStack)

        let expectation = expectation(description: "fetchBook should return no books")

        sut.fetchBook(colorBook) { result in
            switch result {
            case .success(let (book, words)):
                XCTAssertEqual(book.name, bookName)
                XCTAssertEqual(words.count, 0)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }
}
