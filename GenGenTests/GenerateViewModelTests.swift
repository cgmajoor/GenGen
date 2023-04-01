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
        let noRules = [Rule]()
        let sut = GenerateViewModel(rules: noRules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1Rule_generatedStrIsEmpty() throws {
        let category1 = Category(name: "color", items: [])
        let rule1 = Rule(categories: [category1])
        let rules = [rule1]
        let sut = GenerateViewModel(rules: rules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

}
