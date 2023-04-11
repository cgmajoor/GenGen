//
//  RuleServiceTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class RuleServiceTests: XCTestCase {

    func test_addRule_succeeds() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let colorBookName = "color"
        colorBook.name = colorBookName

        let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word.title = "pink"
        word.parentBook = colorBook

        let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let animalBookName = "animal"
        animalBook.name = animalBookName

        let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word2.title = "panda"
        word2.parentBook = animalBook

        let ruleName = "\(colorBookName) \(animalBookName)"
        let books = [colorBook, animalBook]
        let isActive = true

        let expectation = expectation(description: "Expected add rule to succeed")
        testRuleService.addRule(ruleName, books: books, isActive: true) { result in
            switch result {
            case .success(let rule):
                XCTAssertEqual(rule.name, ruleName)
                XCTAssertEqual(rule.active, isActive)
                XCTAssertEqual(rule.bookOrder?.count, 2)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_getRules_with2Rules_returns2Rules() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let colorBookName = "color"
        colorBook.name = colorBookName

        let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word.title = "pink"
        word.parentBook = colorBook

        let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let animalBookName = "animal"
        animalBook.name = animalBookName

        let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word2.title = "panda"
        word2.parentBook = animalBook

        let ruleName = "\(colorBookName) \(animalBookName)"
        let books = [colorBook, animalBook]
        let isActive = true
        let rule = Rule(context: testCoreDataStack.persistentContainer.viewContext)
        rule.name = ruleName
        rule.active = isActive
        books.forEach { rule.addToBookOrder($0) }

        let ruleName2 = "\(colorBookName) \(colorBookName)"
        let books2 = [colorBook, colorBook]
        let isActive2 = false
        let rule2 = Rule(context: testCoreDataStack.persistentContainer.viewContext)
        rule2.name = ruleName2
        rule2.active = isActive2
        books2.forEach { rule.addToBookOrder($0) }
        try testCoreDataStack.saveContext()

        let expectation = expectation(description: "Expected to get 2 rules")
        testRuleService.getRules() { result in
            switch result {
            case .success(let rules):
                XCTAssertEqual(rules.count, 2)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_getRules_with1activeRule_returns1Rule() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let colorBookName = "color"
        colorBook.name = colorBookName

        let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word.title = "pink"
        word.parentBook = colorBook

        let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let animalBookName = "animal"
        animalBook.name = animalBookName

        let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word2.title = "panda"
        word2.parentBook = animalBook

        let ruleName = "\(colorBookName) \(animalBookName)"
        let books = [colorBook, animalBook]
        let isActive = true
        let rule = Rule(context: testCoreDataStack.persistentContainer.viewContext)
        rule.name = ruleName
        rule.active = isActive
        books.forEach { rule.addToBookOrder($0) }

        let ruleName2 = "\(colorBookName) \(colorBookName)"
        let books2 = [colorBook, colorBook]
        let isActive2 = false
        let rule2 = Rule(context: testCoreDataStack.persistentContainer.viewContext)
        rule2.name = ruleName2
        rule2.active = isActive2
        books2.forEach { rule.addToBookOrder($0) }

        try testCoreDataStack.saveContext()

        let expectation = expectation(description: "Expected to get 1 active rule")
        testRuleService.getRules(activeOnly: true) { result in
            switch result {
            case .success(let rules):
                XCTAssertEqual(rules.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

    func test_update_succeeds() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)

        let colorBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let colorBookName = "color"
        colorBook.name = colorBookName

        let word = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word.title = "pink"
        word.parentBook = colorBook

        let animalBook = Book(context: testCoreDataStack.persistentContainer.viewContext)
        let animalBookName = "animal"
        animalBook.name = animalBookName

        let word2 = Word(context: testCoreDataStack.persistentContainer.viewContext)
        word2.title = "panda"
        word2.parentBook = animalBook

        let ruleName = "\(colorBookName) \(animalBookName)"
        let books = [colorBook, animalBook]
        let isActive = true
        let rule1 = Rule(context: testCoreDataStack.persistentContainer.viewContext)
        rule1.name = ruleName
        rule1.active = isActive
        books.forEach { rule1.addToBookOrder($0) }
        try testCoreDataStack.saveContext()

        rule1.active = !isActive

        guard let updatedRule = testRuleService.update(rule1) else {
            XCTFail("Expected update to succeed")
            return
        }
        XCTAssertEqual(updatedRule.name, ruleName)
        XCTAssertEqual(updatedRule.active, !isActive)

    }

}
