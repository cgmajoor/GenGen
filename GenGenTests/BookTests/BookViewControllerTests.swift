//
//  BookViewControllerTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 03/04/2023.
//

import XCTest
@testable import GenGen

final class BookViewControllerTests: XCTestCase {

    func test_viewDidLoad_givenABook_showsHeaderTextCorrectly() throws {
        let testCoreDataStack = TestCoreDataStack()
        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let bookName = "color"
        colorBook.name = bookName
        let mockBookViewModel = BookViewModel(coreDataStack: testCoreDataStack)

        let sut = BookViewController(book: colorBook, viewModel: mockBookViewModel)

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, bookName)
    }

}
