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

    func test_GenerateViewModel_generateReturnsGeneratedStr() throws {
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome)

        let generation = sut.generate()

        XCTAssertEqual(sut.generatedStr, generation)
    }

    func test_GenerateViewModel_withNoRules_generationIsEmpty() throws {
        let sut = makeSut(with: .noRules)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1InactiveRule_generationIsEmpty() throws {
        let sut = makeSut(with: .oneInactiveRule)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWithEmptyCategory_generationIsEmpty() throws {
        let sut = makeSut(with: .oneActiveRuleWithEmptyCategory)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink")
    }

    func test_GenerateViewModel_with1ActiveRuleWith2CategoriesWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith2Categories1PossibleOutcome)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink panda")
    }

    // MARK: - Test Conditions
    enum GeneratorTestCondition {
        case noRules
        case oneInactiveRule
        case oneActiveRuleWithEmptyCategory
        case oneActiveRuleWith1PossibleOutcome
        case oneActiveRuleWith2Categories1PossibleOutcome
    }

    // MARK: - Make System Under Test
    private func makeSut(with testCondition: GeneratorTestCondition) -> GenerateViewModel {
        var sut: GenerateViewModel
        
        let emptyWords = [String]()
        let wordsWith1WordPink = ["pink"]
        let wordsWith1WordPanda = ["panda"]

        let emptyCategory = WordCategory(name: "color", words: emptyWords)
        let colorCategoryWith1Word = WordCategory(name: "colors", words: wordsWith1WordPink)
        let animalCategoryWith1Word = WordCategory(name: "animal", words: wordsWith1WordPanda)

        switch testCondition {
        case .noRules:
            let noRules = [Rule]()
            sut = GenerateViewModel(rules: noRules)
        case .oneInactiveRule:
            let inactiveRule = Rule(active: false, categories: [colorCategoryWith1Word])
            let rules = [inactiveRule]
            sut = GenerateViewModel(rules: rules)
        case .oneActiveRuleWithEmptyCategory:
            let activeRuleWithEmptyCategory = Rule(active: true, categories: [emptyCategory])
            let rules = [activeRuleWithEmptyCategory]
            sut = GenerateViewModel(rules: rules)
        case .oneActiveRuleWith1PossibleOutcome:
            let ruleWith1Category = Rule(active: true, categories: [colorCategoryWith1Word])
            let rules = [ruleWith1Category]
            sut = GenerateViewModel(rules: rules)
        case .oneActiveRuleWith2Categories1PossibleOutcome:
            let activeRuleColorAnimal = Rule(active: true, categories: [colorCategoryWith1Word, animalCategoryWith1Word])
            let rules = [activeRuleColorAnimal]
            sut = GenerateViewModel(rules: rules)
        }
        return sut
    }
}
