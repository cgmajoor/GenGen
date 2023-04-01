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
        let sut = makeSut(with: .noRules)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWithEmptyCategory_generationIsEmpty() throws {
        let sut = makeSut(with: .oneActiveRuleWithEmptyCategory)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink")
    }

    func test_GenerateViewModel_with1InactiveRule_generationIsEmpty() throws {
        let sut = makeSut(with: .oneInactiveRule)

        sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    // MARK: - Test Conditions
    enum TestCondition {
        case noRules
        case oneActiveRuleWithEmptyCategory
        case oneActiveRuleWith1PossibleOutcome
        case oneInactiveRule
    }

    // MARK: - Make System Under Test
    private func makeSut(with testCondition: TestCondition) -> GenerateViewModel {
        var sut: GenerateViewModel
        switch testCondition {
        case .noRules:
            let noRules = [Rule]()
            sut = GenerateViewModel(rules: noRules)
        case .oneActiveRuleWithEmptyCategory:
            let emptyCategory = Category(name: "color", words: [])
            let activeRuleWithEmptyCategory = Rule(active: true, categories: [emptyCategory])
            let rules = [activeRuleWithEmptyCategory]
            sut = GenerateViewModel(rules: rules)
        case .oneActiveRuleWith1PossibleOutcome:
            let oneWord = ["pink"]
            let categoryWith1Word = Category(name: "colors", words: oneWord)
            let ruleWith1Category = Rule(active: true, categories: [categoryWith1Word])
            let rules = [ruleWith1Category]
            sut = GenerateViewModel(rules: rules)
        case .oneInactiveRule:
            let oneWord = ["pink"]
            let categoryWith1Word = Category(name: "colors", words: oneWord)
            let inactiveRule = Rule(active: false, categories: [categoryWith1Word])
            let rules = [inactiveRule]
            sut = GenerateViewModel(rules: rules)
        }
        return sut
    }
}
