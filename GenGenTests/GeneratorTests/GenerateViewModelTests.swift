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

    func test_GenerateViewModel_with1ActiveRuleWithEmptyBook_generationIsEmpty() throws {
        let sut = makeSut(with: .oneActiveRuleWithEmptyBook)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "")
    }

    func test_GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink")
    }

    func test_GenerateViewModel_with1ActiveRuleWith2BooksWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith2Books1PossibleOutcome)

        _ = sut.generate()

        XCTAssertEqual(sut.generatedStr, "pink panda")
    }

    // MARK: - Test Conditions
    enum GeneratorTestCondition {
        case noRules
        case oneInactiveRule
        case oneActiveRuleWithEmptyBook
        case oneActiveRuleWith1PossibleOutcome
        case oneActiveRuleWith2Books1PossibleOutcome
    }

    // MARK: - Make System Under Test
    private func makeSut(with testCondition: GeneratorTestCondition) -> GenerateViewModel {
        var sut: GenerateViewModel
        
        let emptyWords = [String]()
        let wordsWith1WordPink = ["pink"]
        let wordsWith1WordPanda = ["panda"]

        let emptyBook = Book(name: "color", words: emptyWords)
        let colorBookWith1Word = Book(name: "colors", words: wordsWith1WordPink)
        let animalBookWith1Word = Book(name: "animal", words: wordsWith1WordPanda)

        switch testCondition {
        case .noRules:
            let noRules = [Rule]()
            sut = GenerateViewModel(with: noRules)
        case .oneInactiveRule:
            let inactiveRule = Rule(active: false, books: [colorBookWith1Word])
            let rules = [inactiveRule]
            sut = GenerateViewModel(with: rules)
        case .oneActiveRuleWithEmptyBook:
            let activeRuleWithEmptyBook = Rule(active: true, books: [emptyBook])
            let rules = [activeRuleWithEmptyBook]
            sut = GenerateViewModel(with: rules)
        case .oneActiveRuleWith1PossibleOutcome:
            let ruleWith1Book = Rule(active: true, books: [colorBookWith1Word])
            let rules = [ruleWith1Book]
            sut = GenerateViewModel(with: rules)
        case .oneActiveRuleWith2Books1PossibleOutcome:
            let activeRuleColorAnimal = Rule(active: true, books: [colorBookWith1Word, animalBookWith1Word])
            let rules = [activeRuleColorAnimal]
            sut = GenerateViewModel(with: rules)
        }
        return sut
    }

    
}
