//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class LibraryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Dependencies
    var categories: [WordCategory]

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
    init(categories: [WordCategory] = []) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()

        loadWordCategories()
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.wordCategoryTableViewCell, for: indexPath) as? WordCategoryTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(wordCategory: categories[indexPath.row])
        return cell
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
    }

    private func setup() {
        tableView.register(WordCategoryTableViewCell.self, forCellReuseIdentifier: Texts.wordCategoryTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }

    private func loadWordCategories() {
        tableView.reloadData()
    }
}
