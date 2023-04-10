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
        let expectation = expectation(description: "Generate returns generated string")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertFalse(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, success)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_withNoRules_generationIsEmpty() throws {
        let sut = makeSut(with: .noRules)
        let expectation = expectation(description: "GenerateViewModel_withNoRules_generationIsEmpty")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, "")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1InactiveRule_generationIsEmpty() throws {
        let sut = makeSut(with: .oneInactiveRule)
        let expectation = expectation(description: "GenerateViewModel_with1InactiveRule_generationIsEmpty")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, "")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1ActiveRuleWithEmptyBook_generationIsEmpty() throws {
        let sut = makeSut(with: .oneActiveRuleWithEmptyBook)
        let expectation = expectation(description: "GenerateViewModel_with1ActiveRuleWithEmptyBook_generationIsEmpty")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, "")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome)
        let expectation = expectation(description: "GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generationIsCorrect")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertFalse(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, "word1")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1ActiveRuleWith2BooksWith1PossibleOutcome_generationIsCorrect() throws {
        let sut = makeSut(with: .oneActiveRuleWith2Books1PossibleOutcome)
        let expectation = expectation(description: "GenerateViewModel_with1ActiveRuleWith2BooksWith1PossibleOutcome_generationIsCorrect")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertFalse(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, "pink panda")
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
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
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)
        let testBookService = BookService(coreDataStack: testCoreDataStack)
        let testWordService = WordService(coreDataStack: testCoreDataStack)

        // MARK: - Books
        let book1With1Word = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let book1With1WordName = "book1With1WordName"
        book1With1Word.name = book1With1WordName

        let word1 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word1.title = "word1"
        word1.parentBook = book1With1Word

        let book2With1Word = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let book2With1WordName = "book2With1WordName"
        book2With1Word.name = book2With1WordName

        let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word2.title = "word2"
        word2.parentBook = book2With1Word

        switch testCondition {
        case .noRules:
            break
        case .oneInactiveRule:
            let inactiveRule = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            inactiveRule.name = book1With1WordName
            inactiveRule.active = false
            inactiveRule.addToBookOrder(book1With1Word)
        case .oneActiveRuleWithEmptyBook:
            let emptyBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let emptyBookName = "emptyBookName"
            emptyBook.name = emptyBookName

            let oneActiveRuleWithEmptyBook = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWithEmptyBook.name = emptyBookName
            oneActiveRuleWithEmptyBook.active = true
            oneActiveRuleWithEmptyBook.addToBookOrder(emptyBook)
        case .oneActiveRuleWith1PossibleOutcome:
            let oneActiveRuleWith1PossibleOutcome = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWith1PossibleOutcome.name = book1With1WordName
            oneActiveRuleWith1PossibleOutcome.active = true
            oneActiveRuleWith1PossibleOutcome.addToBookOrder(book1With1Word)
        case .oneActiveRuleWith2Books1PossibleOutcome:
            let oneActiveRuleWith2Books1PossibleOutcome = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWith2Books1PossibleOutcome.name = "\(book1With1WordName) \(book2With1WordName)"
            oneActiveRuleWith2Books1PossibleOutcome.active = true
            oneActiveRuleWith2Books1PossibleOutcome.addToBookOrder(book1With1Word)
            oneActiveRuleWith2Books1PossibleOutcome.addToBookOrder(book2With1Word)
        }
        return GenerateViewModel(ruleService: testRuleService, bookService: testBookService, wordService: testWordService)
    }


}
