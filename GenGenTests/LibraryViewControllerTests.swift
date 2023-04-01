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
        let sut = makeSut(with: .noCategories)

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, Texts.libraryNavigationTitle)
    }

    func test_viewDidLoad_withNoCategories_showsNoCategories() throws {
        let sut = makeSut(with: .noCategories)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_with1Category_shows1Category() throws {
        let sut = makeSut(with: .oneCategory)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_with2Categories_shows2Categories() throws {
        let sut = makeSut(with: .twoCategories)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

    // MARK: - Test Conditions
    enum LibraryTestCondition {
        case noCategories
        case oneCategory
        case twoCategories
    }

    // MARK: - Make System Under Test
    private func makeSut(with testCondition: LibraryTestCondition) -> LibraryViewController {
        var sut: LibraryViewController

        let emptyCategory = WordCategory(name: "color", words: [])
        let category1 = WordCategory(name: "color", words: [])
        let category2 = WordCategory(name: "animal", words: [])

        let noCategories = [WordCategory]()
        let oneCategory = [emptyCategory]
        let twoCategories = [category1, category2]

        switch testCondition {
        case .noCategories:
            sut = LibraryViewController(categories: noCategories)
        case .oneCategory:
            sut = LibraryViewController(categories: oneCategory)
        case .twoCategories:
            sut = LibraryViewController(categories: twoCategories)
        }
        return sut
    }
}
