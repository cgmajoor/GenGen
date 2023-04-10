//
//  RulesViewModelTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class RulesViewModelTests: XCTestCase {

    func test_fetchRules_WithNoRules_returnsNoRules() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)
        let sut = RulesViewModel(ruleService: testRuleService)

        let expectation = expectation(description: "Given no rules fetchRules should return no rules")

        sut.fetchRules { result in
            switch result {
            case .success(let rules):
                XCTAssertEqual(rules.count, 0)
                expectation.fulfill()
            case .failure(let failure):
                XCTFail("Failed: \(failure)")
            }
        }
        waitForExpectations(timeout: 2.0)
    }

}

