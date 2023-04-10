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
        let sut = makeSut(with: .noBooks)

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, Texts.libraryNavigationTitle)
    }

    func test_viewDidLoad_withNoBooks_showsNoBooks() throws {
        let sut = makeSut(with: .noBooks)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_viewDidLoad_with1Book_shows1Book() throws {
        let sut = makeSut(with: .oneBook)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_with2Books_shows2Books() throws {
        let sut = makeSut(with: .twoBooks)

        _ = sut.view

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

    // MARK: - Test Conditions
    enum LibraryTestCondition {
        case noBooks
        case oneBook
        case twoBooks
    }

    // MARK: - Make System Under Test
    private func makeSut(with testCondition: LibraryTestCondition) -> LibraryViewController {
        var sut: LibraryViewController

        switch testCondition {
        case .noBooks:
            let testCoreDataStack = TestCoreDataStack()
            let testBookService = BookService(coreDataStack: testCoreDataStack)

            let testLibraryViewModel = LibraryViewModel(bookService: testBookService)

            sut = LibraryViewController(viewModel: testLibraryViewModel)
        case .oneBook:
            let testCoreDataStack = TestCoreDataStack()
            let testBookService = BookService(coreDataStack: testCoreDataStack)

            let book1 = Book(context: testCoreDataStack.persistentContainer.viewContext)
            book1.name = "color"
            book1.words = []
            
            let oneBook = [book1]

            let testLibraryViewModel = LibraryViewModel(bookService: testBookService, books: oneBook)

            sut = LibraryViewController(viewModel: testLibraryViewModel)
        case .twoBooks:
            let testCoreDataStack = TestCoreDataStack()
            let testBookService = BookService(coreDataStack: testCoreDataStack)

            let book1 = Book(context: testCoreDataStack.persistentContainer.viewContext)
            book1.name = "color"
            book1.words = []

            let book2 = Book(context: testCoreDataStack.persistentContainer.viewContext)
            book2.name = "animal"
            book2.words = []

            let twoBooks = [book1, book2]

            let testLibraryViewModel = LibraryViewModel(bookService: testBookService, books: twoBooks)

            sut = LibraryViewController(viewModel: testLibraryViewModel)
        }
        return sut
    }
}
