//
//  RuleCreatorViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

class RuleCreatorViewController: UIViewController {
    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.rules,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.ruleCreatorNavigationTitle)

    private lazy var doneButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.checkMark,
                                            style: .plain,
                                            target: self,
                                            action: #selector(doneTapped))
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()
    }
    
    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
        navigationItem.rightBarButtonItem = doneButton
    }

    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background

    }

    // MARK: - Actions
    @objc private func doneTapped() {
        print("done tapped")
    }
}
