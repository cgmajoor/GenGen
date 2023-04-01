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

    func test_GenerateViewModel_withNoRules_generationIsEmpty() throws {
        let noRules = [Rule]()
        let sut = GenerateViewModel(rules: noRules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWithEmptyCategory_generationIsEmpty() throws {
        let emptyCategory = Category(name: "color", words: [])
        let activeRuleWithEmptyCategory = Rule(active: true, categories: [emptyCategory])
        let rules = [activeRuleWithEmptyCategory]
        let sut = GenerateViewModel(rules: rules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWith1Possibility_generationIsCorrect() throws {
        let oneWord = ["pink"]
        let categoryWith1Word = Category(name: "colors", words: oneWord)
        let ruleWith1Category = Rule(active: true, categories: [categoryWith1Word])
        let rules = [ruleWith1Category]
        let sut = GenerateViewModel(rules: rules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink")
    }
}
