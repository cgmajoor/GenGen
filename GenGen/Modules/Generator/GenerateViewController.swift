//
//  GenerateViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class GenerateViewController: BaseViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()

    }

    // MARK: - Configurations
    
    private func configureNavigationItems() {
        self.navigationItem.titleView = UIImageView(image: AppTheme.Navigation.Image.logo)
        let helpButton = UIBarButtonItem(image: AppTheme.Navigation.Image.help, style: .plain, target: self, action: #selector(helpTapped))
        self.navigationItem.setRightBarButton(helpButton, animated: false)
    }

    // MARK: - Actions

    @objc private func helpTapped() {
        print("help tapped")
    }
}
