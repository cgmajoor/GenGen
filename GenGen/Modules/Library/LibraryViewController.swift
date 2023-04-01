//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class LibraryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        let label = UILabel()
        label.textColor = AppTheme.Navigation.Color.library
        label.font = AppTheme.Navigation.FontStyle.title
        label.text = "Library"
        self.navigationItem.titleView = label
    }
}
