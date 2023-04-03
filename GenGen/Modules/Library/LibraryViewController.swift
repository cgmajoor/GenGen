//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class LibraryViewController: BaseViewController {

    // MARK: - Dependencies
    private var viewModel: BookProvider
    var books: [Book] = []

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
    init(viewModel: BookProvider = LibraryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()

        loadBooks()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
    }

    private func setup() {
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Texts.libraryTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }

    // MARK: - Internal Methods
    private func loadBooks() {
        self.books = viewModel.fetchBooks()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.libraryTableViewCell, for: indexPath) as? LibraryTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(book: books[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelect: \(books[indexPath.row].name)")
    }
}
