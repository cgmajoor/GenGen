////
////  LibraryViewControllerTests.swift
////  GenGenTests
////
////  Created by Ceren Gazioglu Majoor on 01/04/2023.
////
//
//import XCTest
//@testable import GenGen
//
//final class LibraryViewControllerTests: XCTestCase {
//
//    func test_viewDidLoad_showsHeaderText() throws {
//        let sut = makeSut(with: .noBooks)
//
//        _ = sut.view
//
//        XCTAssertEqual(sut.headerLabel.text, Texts.libraryNavigationTitle)
//    }
//
//    func test_viewDidLoad_withNoBooks_showsNoBooks() throws {
//        let sut = makeSut(with: .noBooks)
//
//        _ = sut.view
//
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
//    }
//
//    func test_viewDidLoad_with1Book_shows1Book() throws {
//        let sut = makeSut(with: .oneBook)
//
//        _ = sut.view
//
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
//    }
//
//    func test_viewDidLoad_with2Books_shows2Books() throws {
//        let sut = makeSut(with: .twoBooks)
//
//        _ = sut.view
//
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
//    }
//
//    // MARK: - Test Conditions
//    enum LibraryTestCondition {
//        case noBooks
//        case oneBook
//        case twoBooks
//    }
//
//    // MARK: - Make System Under Test
//    private func makeSut(with testCondition: LibraryTestCondition) -> LibraryViewController {
//        var sut: LibraryViewController
//
//        switch testCondition {
//        case .noBooks:
//            let mockViewModel = MockLibraryViewModel()
//            sut = LibraryViewController(viewModel: mockViewModel)
//        case .oneBook:
//            let mockViewModel = MockLibraryViewModelWithOneBook()
//            sut = LibraryViewController(viewModel: mockViewModel)
//        case .twoBooks:
//            let mockViewModel = MockLibraryViewModelWithTwoBooks()
//            sut = LibraryViewController(viewModel: mockViewModel)
//        }
//        return sut
//    }
//}
