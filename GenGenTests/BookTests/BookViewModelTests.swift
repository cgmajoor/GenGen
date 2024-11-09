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

    func test_fetchWords_withBookWithNoWords_returnsNoWords() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testWordService = WordService(coreDataStack: testCoreDataStack)
        
        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let bookName = "color"
        colorBook.name = bookName
        let sut = BookViewModel(wordService: testWordService, book: colorBook)

        let expectation = expectation(description: "fetchWords with a book with no words should return no words")

        sut.fetchWords(for: colorBook) { result in
            switch result {
            case .success(let words):
                XCTAssertEqual(words.count, 0)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_fetchWords_withBookWith1Word_returns1Word() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testWordService = WordService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let bookName = "color"
        colorBook.name = bookName

        let word1 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word1.title = "word1"
        word1.parentBook = colorBook

        let sut = BookViewModel(wordService: testWordService, book: colorBook)

        let expectation = expectation(description: "fetchWords with a book with 1 word should return 1 word")

        sut.fetchWords(for: colorBook) { result in
            switch result {
            case .success(let words):
                XCTAssertEqual(words.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_fetchWords_returnsCorrectWords() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testWordService = WordService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let colorBookName = "color"
        colorBook.name = colorBookName

        let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let animalBookName = "animal"
        animalBook.name = animalBookName

        let colorWord = Word(context: testCoreDataStack.persistentContainer.viewContext)
        colorWord.title = "colorWord"
        colorWord.parentBook = colorBook

        let animalWord = Word(context: testCoreDataStack.persistentContainer.viewContext)
        animalWord.title = "animalWord"
        animalWord.parentBook = animalBook

        let sut = BookViewModel(wordService: testWordService, book: colorBook)

        let expectation = expectation(description: "fetchWords should return correct words")

        sut.fetchWords(for: colorBook) { result in
            switch result {
            case .success(let words):
                XCTAssertEqual(words.count, 1)
                XCTAssertEqual(words.first, colorWord)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }
}
