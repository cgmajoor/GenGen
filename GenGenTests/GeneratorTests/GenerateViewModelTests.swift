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
        let sut = makeSut(with: .noRules, expectedOutput: "")

        let expectation = expectation(description: "Generate returns empty")

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

    func test_GenerateViewModel_with1ActiveRuleWith1PossibleOutcome_generateReturnsGeneratedStrCorrectly() throws {
        let expectedOutput = "pink"
        let sut = makeSut(with: .oneActiveRuleWith1PossibleOutcome, expectedOutput: expectedOutput)

        let expectation = expectation(description: "Generate returns generated string")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertFalse(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, success)
                XCTAssertEqual(sut.generatedStr, expectedOutput)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1InactiveRule_generationIsEmpty() throws {
        let expectedOutput = ""
        let sut = makeSut(with: .oneInactiveRule, expectedOutput: expectedOutput)

        let expectation = expectation(description: "Generate with an inactive rule returns empty string")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, expectedOutput)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1ActiveRuleWithEmptyBook_generationIsEmpty() throws {
        let expectedOutput = ""
        let sut = makeSut(with: .oneActiveRuleWithEmptyBook, expectedOutput: expectedOutput)

        let expectation = expectation(description: "Generate with an active rule with empty book returns empty string")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, expectedOutput)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Expectation failed: \(expectation). \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_GenerateViewModel_with1ActiveRuleWith2BooksWith1PossibleOutcome_generationIsCorrect() throws {
        let wordTitle = "pink"
        let wordTitle2 = "panda"
        let expectedOutput = "\(wordTitle) \(wordTitle2)"
        let sut = makeSut(with: .oneActiveRuleWith2Books1PossibleOutcome, expectedOutput: expectedOutput)

        let expectation = expectation(description: "Generate with 1 active rule with 2 books with 1 possible outcome generates correct output")

        let _ = sut.generate { result in
            switch result {
            case .success(let success):
                XCTAssertFalse(success.isEmpty)
                XCTAssertEqual(sut.generatedStr, success)
                XCTAssertEqual(sut.generatedStr, expectedOutput)
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
    private func makeSut(with testCondition: GeneratorTestCondition, expectedOutput: String) -> GenerateViewModel {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)
        let testBookService = BookService(coreDataStack: testCoreDataStack)
        let testWordService = WordService(coreDataStack: testCoreDataStack)
        let sut = GenerateViewModel(ruleService: testRuleService, bookService: testBookService, wordService: testWordService)

        // MARK: - Books

        switch testCondition {
        case .noRules:
            print("no rules")

        case .oneInactiveRule:
            let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let colorBookName = "color"
            colorBook.name = colorBookName

            let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
            let wordTitle = "pink"
            word.title = wordTitle
            word.parentBook = colorBook

            let ruleName = "\(colorBookName)"
            let books = [colorBook]
            let isActive = false

            let oneInactiveRule = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneInactiveRule.name = ruleName
            oneInactiveRule.active = isActive
            books.forEach { oneInactiveRule.addToBookOrder($0) }

            sut.activeRules = []
            sut.activeBooksWithWords[colorBookName] = [wordTitle]

        case .oneActiveRuleWithEmptyBook:
            let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let colorBookName = "color"
            colorBook.name = colorBookName

            let ruleName = "\(colorBookName)"
            let books = [colorBook]
            let isActive = true

            let oneActiveRuleWith1PossibleOutcome = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWith1PossibleOutcome.name = ruleName
            oneActiveRuleWith1PossibleOutcome.active = isActive
            books.forEach { oneActiveRuleWith1PossibleOutcome.addToBookOrder($0) }

            sut.activeRules = [oneActiveRuleWith1PossibleOutcome]

        case .oneActiveRuleWith1PossibleOutcome:
            let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let colorBookName = "color"
            colorBook.name = colorBookName

            let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
            let wordTitle = expectedOutput
            word.title = wordTitle
            word.parentBook = colorBook

            let ruleName = "\(colorBookName)"
            let books = [colorBook]
            let isActive = true

            let oneActiveRuleWith1PossibleOutcome = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWith1PossibleOutcome.name = ruleName
            oneActiveRuleWith1PossibleOutcome.active = isActive
            books.forEach { oneActiveRuleWith1PossibleOutcome.addToBookOrder($0) }

            sut.activeRules = [oneActiveRuleWith1PossibleOutcome]
            sut.activeBooksWithWords[colorBookName] = [wordTitle]

        case .oneActiveRuleWith2Books1PossibleOutcome:
            let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let colorBookName = "color"
            colorBook.name = colorBookName

            let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
            let wordTitle = "pink"
            word.title = wordTitle
            word.parentBook = colorBook

            let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
            let animalBookName = "animal"
            animalBook.name = animalBookName

            let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
            let wordTitle2 = "panda"
            word2.title = wordTitle2
            word2.parentBook = animalBook

            let ruleName = "\(colorBookName) \(animalBookName)"
            let books = [colorBook, animalBook]
            let isActive = true

            let oneActiveRuleWith2Books = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneActiveRuleWith2Books.name = ruleName
            oneActiveRuleWith2Books.active = isActive
            books.forEach { oneActiveRuleWith2Books.addToBookOrder($0) }

            let ruleName2 = "\(colorBookName)"
            let books2 = [colorBook]
            let isActive2 = false

            let oneInactiveRule = Rule(context: testCoreDataStack.persistentContainer.viewContext)
            oneInactiveRule.name = ruleName2
            oneInactiveRule.active = isActive2
            books2.forEach { oneInactiveRule.addToBookOrder($0) }

            sut.activeRules = [oneActiveRuleWith2Books]
            sut.activeBooksWithWords[colorBookName] = [wordTitle]
            sut.activeBooksWithWords[animalBookName] = [wordTitle2]
        }
        return sut
    }

}
