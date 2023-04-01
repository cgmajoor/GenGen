//
//  GenerateViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class GenerateViewController: BaseViewController {

    // MARK: - Dependencies
    var generateViewModel: Generating

    // MARK: - UI
    private lazy var helpButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.help,
                                            style: .plain,
                                            target: self,
                                            action: #selector(helpTapped))
        return barButtonItem
    }()
    
    private lazy var generateButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.buttonBackground, title: "Generate")
        button.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    init(generateViewModel: Generating = GenerateViewModel()) {
        self.generateViewModel = generateViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()
    }

    // MARK: - Setup
    private func setup() {
        view.addSubview(generateButton)

        NSLayoutConstraint.activate([
            generateButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            generateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppTheme.Main.Padding.horizontal),
            generateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppTheme.Main.Padding.horizontal),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Main.Padding.vertical)
        ])
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = UIImageView(image: AppTheme.Navigation.Image.logo)
        self.navigationItem.setRightBarButton(helpButton, animated: false)
    }

    // MARK: - Actions
    @objc private func helpTapped() {
        print("help tapped")
    }

    @objc private func generateTapped() {
        generateViewModel.generate()
    }
}
