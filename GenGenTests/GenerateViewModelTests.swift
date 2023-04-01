//
//  GenerateViewModelTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation
import XCTest
@testable import GenGen

final class GenerateViewModelTests: XCTestCase {

    func test_GenerateViewModel_withNoRules_generatedStrIsEmpty() throws {
        let noRules = [[String]]()
        let sut = GenerateViewModel(rules: noRules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

}
