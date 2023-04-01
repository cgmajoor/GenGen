//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class LibraryViewController: BaseViewController, UITableViewDataSource {

    // MARK: - Dependencies
    var categories: [Category]

    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.library,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.libraryNavigationTitle)

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - LifeCycle
    init(categories: [Category] = []) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
    }
}
