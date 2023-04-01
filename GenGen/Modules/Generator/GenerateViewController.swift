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
    private lazy var generationLabel = GGLabel(backgroundColor: AppTheme.Main.Color.labelBackground,
                                               fullText: "")

    private lazy var helpButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.help,
                                            style: .plain,
                                            target: self,
                                            action: #selector(helpTapped))
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()
    
    private lazy var generateButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.buttonBackground, title: Texts.generateButtonTitle)
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
        view.addSubview(generationLabel)
        view.addSubview(generateButton)

        let horizontalPadding = AppTheme.Main.Padding.horizontal
        let verticalPadding = AppTheme.Main.Padding.horizontal

        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalPadding),
            generationLabel.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: -verticalPadding),
            generationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            generationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),

            generateButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            generateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding),
            generateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalPadding)
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
        generationLabel.text = generateViewModel.generate()
    }
}
