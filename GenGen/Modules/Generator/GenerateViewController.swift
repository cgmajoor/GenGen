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

    private lazy var openAIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppTheme.Main.Image.openAI, for: .normal)  // Replace with your OpenAI icon
        button.addTarget(self, action: #selector(openAITapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppTheme.Main.Image.addFav, for: .normal)
        button.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    init(
        viewModel: Generating = GenerateViewModel(
            addFavoriteUseCase: AddFavoriteIfNotExistsUseCase(
                favoriteService: AppDependencies.shared.favoriteService
            )
        ),
        router: GeneratorRouting = GeneratorRouter()
    ) {
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
        view.addSubview(addToFavoritesButton)
        view.addSubview(openAIButton)

        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Padding.vertical),
            generationLabel.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: -AppTheme.Padding.vertical),
            generationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Padding.horizontal),
            generationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Padding.horizontal),

            addToFavoritesButton.topAnchor.constraint(equalTo: generationLabel.topAnchor, constant: AppTheme.Padding.vertical),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: generationLabel.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            addToFavoritesButton.widthAnchor.constraint(equalToConstant: 44),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 44),

            openAIButton.bottomAnchor.constraint(equalTo: generationLabel.bottomAnchor, constant: -AppTheme.Padding.vertical),
            openAIButton.trailingAnchor.constraint(equalTo: generationLabel.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            openAIButton.widthAnchor.constraint(equalToConstant: 44),
            openAIButton.heightAnchor.constraint(equalToConstant: 44),

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

    @objc private func addToFavoritesTapped() {
        guard let text = generationLabel.text, !text.isEmpty else { return }
        viewModel.addFavorite(text) { result in
            switch result {
            case .success:
                print("Favorite added successfully")
                NotificationCenter.default.post(name: .favoritesUpdated, object: nil) // Notify of update
            case .failure(let error):
                print("Failed to add favorite: \(error)")
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

    @objc private func openAITapped() {
        let apiKey = Environment.apiKey

        guard let textToGenerate = generationLabel.text, !textToGenerate.isEmpty else {
            print("No text to generate ideas from.")
            return
        }

        generateButton.isEnabled = false
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.center = openAIButton.center
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()

        Task {
            defer {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating()
                    loadingIndicator.removeFromSuperview()
                    self.generateButton.isEnabled = true
                }
            }

            let result = await fetchOpenAIResponse(prompt: textToGenerate, apiKey: apiKey)

            DispatchQueue.main.async {
                if let responseText = result {
                    self.generationLabel.text = responseText
                } else {
                    print("Failed to get response from OpenAI.")
                }
            }
        }
    }

    private func fetchOpenAIResponse(prompt: String, apiKey: String) async -> String? {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Give related text for '\(prompt)' in less than 20 tokens."]],
            "max_tokens": 100,
            "temperature": 0.5
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        dump(request, name: "🌍OpenAI request")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = jsonObject["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                dump(jsonObject, name: "🌍OpenAI request")
                return content.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } catch {
            print("Error fetching OpenAI response: \(error)")
        }
        return nil
    }
}
