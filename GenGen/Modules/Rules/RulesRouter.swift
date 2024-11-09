//
//  RulesRouter.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import Foundation
import CoreData

protocol RulesRouting {
    func didSelectAdd(in viewController: RulesViewController)
}

class RulesRouter: RulesRouting {
    func didSelectAdd(in viewController: RulesViewController) {
        let ruleCreatorViewController = RuleCreatorViewController()
        viewController.navigationController?.pushViewController(ruleCreatorViewController, animated: true)
    }
}
