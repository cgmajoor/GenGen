//
//  GenerateViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class GenerateViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()

    }

    private func configureNavigationItems() {
        self.navigationItem.titleView = UIImageView(image: AppTheme.Navigation.Image.logo)
        let helpButton = UIBarButtonItem(image: AppTheme.Navigation.Image.help, style: .plain, target: self, action: #selector(helpTapped))
        self.navigationItem.setRightBarButton(helpButton, animated: false)
    }

    @objc private func helpTapped() {
        print("help tapped")
    }
}
