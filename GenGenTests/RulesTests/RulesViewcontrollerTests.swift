//
//  RulesViewcontrollerTests.swift
//  GenGenTests
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import XCTest
import CoreData
@testable import GenGen

final class RulesViewcontrollerTests: XCTestCase {

    func test_viewDidLoad_showsHeaderTextCorrectly() throws {
        let testCoreDataStack = TestCoreDataStack()
        let testRuleService = RuleService(coreDataStack: testCoreDataStack)
        let testRulesViewModel = RulesViewModel(ruleService: testRuleService)

        let sut = RulesViewController(viewModel: testRulesViewModel)

        _ = sut.view

        XCTAssertEqual(sut.headerLabel.text, "Rules")
    }

}
