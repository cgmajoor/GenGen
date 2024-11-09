//
//  OnboardingViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import UIKit

class OnboardingViewController: BaseViewController {
    // MARK: - Properties
    var viewModel: OnboardingViewModel

    // MARK: - UI
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.imageView?.image = AppTheme.Navigation.Image.close
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = AppTheme.Main.Color.buttonBackground
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = .zero
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.estimatedItemSize = .zero
        return collectionViewLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Lifecycle
    init(viewModel: OnboardingViewModel = OnboardingViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: Texts.onboardingCollectionViewCell)

        view.embedToSafeArea(view: collectionView)

        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AppTheme.Padding.vertical),
            closeButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.squareIconHeight),
            closeButton.widthAnchor.constraint(equalToConstant: AppTheme.Main.Size.squareIconHeight),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -AppTheme.Padding.horizontal)
        ])
    }

    // MARK: - Actions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.contentImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Texts.onboardingCollectionViewCell,
            for: indexPath) as? OnboardingCollectionViewCell else
        { return UICollectionViewCell() }

        let image = self.viewModel.contentImages[indexPath.row]
        print("Color for \(indexPath.row) of \(AppTheme.Onboarding.backgroundColors.count)")
        let backgroundColor = AppTheme.Onboarding.backgroundColors[indexPath.row % AppTheme.Onboarding.backgroundColors.count]
        cell.configure(image: image, backgroundColor: backgroundColor)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}
