//
//  LibraryViewControllerTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import XCTest
@testable import GenGen

final class LibraryViewControllerTests: XCTestCase {

    func test_viewDidLoad_showsHeaderText() throws {
        let sut = LibraryViewController(categories: [])

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, Texts.libraryNavigationTitle)
    }

    func test_viewDidLoad_withNoCategories_showsNoCategories() throws {
        let sut = LibraryViewController(categories: [])

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

}
