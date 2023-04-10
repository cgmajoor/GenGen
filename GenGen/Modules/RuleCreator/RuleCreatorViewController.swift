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

    lazy var addButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.pickUpBackground, image: AppTheme.Main.Image.pickUp)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
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

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        view.addSubview(addButton)

        let horizontalPadding = AppTheme.Main.Padding.horizontal
        let verticalPadding = AppTheme.Main.Padding.horizontal

        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalPadding)
        ])
    }

    // MARK: - Actions
    @objc private func doneTapped() {
        print("done tapped")
    }

    @objc private func addTapped() {
        print("add tapped")
    }
}
