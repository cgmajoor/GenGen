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
        let sut = LibraryViewController()

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, Texts.libraryNavigationTitle)
    }

}
