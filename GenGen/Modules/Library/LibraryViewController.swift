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

    private func configureNavigationItems() {
        self.navigationItem.title = "Library"
    }
}
