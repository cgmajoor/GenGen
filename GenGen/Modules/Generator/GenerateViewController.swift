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
    private let gptTypes: [GPTType] = [.defaultGenerate, .ai2Cents, .rhyme, .joke, .mnemonic]
    private let useCases: [GenerateTextWithOpenAIUseCaseProtocol]
    private var isFirstCellEnabled = false

    // MARK: - UI
    private lazy var gengenLogo = UIImageView(image: AppTheme.Navigation.Image.logo)
    private lazy var generationLabel = GGLabel(
        backgroundColor: AppTheme.Main.Color.labelBackground,
        fullText: ""
    )

    private lazy var helpButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: AppTheme.Navigation.Image.help,
            style: .plain,
            target: self,
            action: #selector(helpTapped)
        )
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()

    private lazy var gptCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GPTCell.self, forCellWithReuseIdentifier: "GPTCell")
        return collectionView
    }()

    private lazy var addToFavoritesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppTheme.Main.Image.addFav, for: .normal)
        button.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    init(viewModel: Generating = GenerateViewModel(), router: GeneratorRouting = GeneratorRouter()) {
        self.viewModel = viewModel
        self.router = router
        self.useCases = [
            GenerateRelatedTextUseCase(),
            GenerateRhymeUseCase(),
            GenerateJokeUseCase(),
            GenerateMnemonicUseCase()
        ]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()

        gptCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
    }

    override func viewWillAppear(_ animated: Bool) {
        loadActiveRules()
    }

    // MARK: - Setup
    private func setup() {
        view.addSubview(generationLabel)
        view.addSubview(gptCollectionView)
        view.addSubview(addToFavoritesButton)

        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Padding.vertical),
            generationLabel.bottomAnchor.constraint(equalTo: gptCollectionView.topAnchor, constant: -AppTheme.Padding.vertical),
            generationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppTheme.Padding.horizontal),
            generationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppTheme.Padding.horizontal),

            addToFavoritesButton.topAnchor.constraint(equalTo: generationLabel.topAnchor, constant: AppTheme.Padding.vertical),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: generationLabel.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            addToFavoritesButton.widthAnchor.constraint(equalToConstant: 44),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 44),

            gptCollectionView.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            gptCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: AppTheme.Padding.horizontal),
            gptCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            gptCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AppTheme.Padding.vertical)
        ])
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = gengenLogo
        self.navigationItem.setRightBarButton(helpButton, animated: false)
    }

    // MARK: - Internal Methods
    private func loadActiveRules() {
        viewModel.getActiveRules { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let activeRules):
                self.isFirstCellEnabled = !activeRules.isEmpty
            case .failure:
                self.isFirstCellEnabled = false
            }
            self.gptCollectionView.reloadData()
        }
    }

    @objc private func addToFavoritesTapped() {
        guard let text = generationLabel.text, !text.isEmpty else { return }
        viewModel.addFavorite(text) { result in
            switch result {
            case .success:
                print("Favorite added successfully")
                NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
            case .failure(let error):
                print("Failed to add favorite: \(error)")
            }
        }
    }

    // MARK: - Actions
    @objc private func helpTapped() {
        router.didSelectHelp(in: self)
    }
}
extension GenerateViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Collection View Data Source and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gptTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GPTCell", for: indexPath) as? GPTCell else {
            return UICollectionViewCell()
        }
        let gptType = gptTypes[indexPath.item]
        cell.configure(with: gptType)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            guard isFirstCellEnabled else {
                print("First cell is disabled.")
                return
            }
            print("First cell is enabled.")

            viewModel.generate { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.generationLabel.text = response
                    case .failure(let error):
                        print("Error generating: \(error)")
                    }
                }
            }
        } else {
            guard let prompt = generationLabel.text, !prompt.isEmpty else {
                print("Prompt is empty.")
                return
            }

            let selectedUseCase = useCases[indexPath.item - 1]
            selectedUseCase.execute(for: prompt) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.generationLabel.text = response
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}
