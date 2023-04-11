//
//  GenerateViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class GenerateViewController: BaseViewController {

    // MARK: - Properties
    var viewModel: Generating
    private var router: GeneratorRouting

    // MARK: - UI
    private lazy var gengenLogo = UIImageView(image: AppTheme.Navigation.Image.logo)
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
    
    lazy var generateButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.buttonBackground, title: Texts.generateButtonTitle)
        button.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    init(viewModel: Generating = GenerateViewModel(), router: GeneratorRouting = GeneratorRouter()) {
        self.viewModel = viewModel
        self.router = router
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

    override func viewWillAppear(_ animated: Bool) {
        loadActiveRules()
    }

    // MARK: - Setup
    private func setup() {
        view.addSubview(generationLabel)
        view.addSubview(generateButton)

        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Padding.vertical),
            generationLabel.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: -AppTheme.Padding.vertical),
            generationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Padding.horizontal),
            generationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Padding.horizontal),

            generateButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            generateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppTheme.Padding.horizontal),
            generateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Padding.vertical)
        ])
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = gengenLogo
        self.navigationItem.setRightBarButton(helpButton, animated: false)
    }

    // MARK: - Internal Methods
    private func loadActiveRules() {
        self.generateButton.isEnabled = false
        viewModel.getActiveRules { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.generateButton.isEnabled = true
            case .failure(let failure):
                print("Error loading active rules: \(failure)")
            }
        }
    }

    // MARK: - Actions
    @objc private func helpTapped() {
        router.didSelectHelp(in: self)
    }

    @objc private func generateTapped() {
        viewModel.generate { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.generationLabel.text = success
            case .failure(let failure):
                print("Error generating: \(failure)")
            }
        }
    }
}
