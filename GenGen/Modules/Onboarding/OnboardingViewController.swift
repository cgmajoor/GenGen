//
//  OnboardingViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import UIKit

class OnboardingViewController: UIViewController {

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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
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
