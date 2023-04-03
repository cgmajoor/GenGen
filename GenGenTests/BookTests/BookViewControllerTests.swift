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
        let book = Book(name: "color", words: [])
        let sut = BookViewController(book: book)

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, book.name)
    }

}
