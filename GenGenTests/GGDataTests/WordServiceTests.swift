//
//  WordServiceTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class WordServiceTests: XCTestCase {

    func test_addWord_succeeds() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testWordService = WordService(coreDataStack: testCoreDataStack)
        let word = "red"

        let book = Book(context: testCoreDataStack.persistentContainer.viewContext)
        book.name = "color"

        let expectation = expectation(description: "Expected add word to succeed")
        testWordService.addWord(word, to: book) { result in
            switch result {
            case .success(let (book, word)):
                XCTAssertEqual(book.words?.count, 1)
                XCTAssertEqual(word.parentBook?.name, book.name)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_getWords_givenBookWith1Word_returns1WordCorrectly() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testWordService = WordService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let bookName = "color"
        colorBook.name = bookName

        let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word.title = "red"
        word.parentBook = colorBook

        let expectation = expectation(description: "Expected words to return 1 word correctly")
        testWordService.getWords(for: colorBook) { result in
            switch result {
            case .success(let words):
                XCTAssertEqual(words.count, 1)
                XCTAssertEqual(words.first?.title, word.title)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

}
