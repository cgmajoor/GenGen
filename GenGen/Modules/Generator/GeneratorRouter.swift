//
//  GeneratorRouter.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import Foundation
import CoreData

protocol GeneratorRouting {
    func didSelectHelp(in viewController: GenerateViewController)
}

class GeneratorRouter: GeneratorRouting {
    func didSelectHelp(in viewController: GenerateViewController) {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        viewController.navigationController?.showDetailViewController(onboardingViewController, sender: viewController)
    }
}
