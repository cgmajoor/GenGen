//
//  RuleCreatorViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

class RuleCreatorViewController: UIViewController {

    // MARK: - Properties
    var selectedBooks: [Book] = []

    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.rules,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.ruleCreatorNavigationTitle)

    private lazy var doneButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.checkMark,
                                            style: .plain,
                                            target: self,
                                            action: #selector(doneTapped))
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()


    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var addButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.pickUpBackground, image: AppTheme.Main.Image.pickUp)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()
    }
    
    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
        navigationItem.rightBarButtonItem = doneButton
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Texts.libraryTableViewCell)
        tableView.dataSource = self

        view.addSubview(tableView)
        view.addSubview(addButton)

        let horizontalPadding = AppTheme.Main.Padding.horizontal
        let verticalPadding = AppTheme.Main.Padding.horizontal

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalPadding),
            tableView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3.0)),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding),

            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: verticalPadding),
            addButton.heightAnchor.constraint(equalToConstant: AppTheme.Main.Size.buttonHeight),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding),
        ])
    }

    // MARK: - Actions
    @objc private func doneTapped() {
        print("done tapped")
    }

    @objc private func addTapped() {
        print("add tapped")
    }
}


// MARK: - UITableViewDataSource
extension RuleCreatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.libraryTableViewCell, for: indexPath) as? LibraryTableViewCell,
              let bookName = selectedBooks[indexPath.row].name else {
            return UITableViewCell()
        }
        cell.configure(bookName: bookName)
        return cell
    }
}
