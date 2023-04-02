//
//  GenerateViewControllerTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import XCTest
@testable import GenGen

final class GenerateViewControllerTests: XCTestCase {

    func test_viewDidLoad_showsGenerateButton() throws {
        let sut = GenerateViewController()

        _ = sut.view

        XCTAssertFalse(sut.generateButton.isHidden)
        XCTAssertEqual(sut.generateButton.titleLabel?.text, Texts.generateButtonTitle)
    }

}
