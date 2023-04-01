//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class LibraryViewController: BaseViewController {

    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.library,
                                  font:AppTheme.Navigation.FontStyle.title,
                                  fullText: Texts.libraryNavigationTitle)
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
    }
}
