//
//  RuleCreatorViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

class RuleCreatorViewController: UIViewController {

    // MARK: - Properties
    private var books: [Book] = []
    private var selectedBooks: [Book] = []
    private var selectedBook: Book?
    private var viewModel: RuleCreatorViewModelProtocol

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
        tableView.backgroundColor = AppTheme.Main.Color.tableViewBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var addButton: GGButton = {
        let button = GGButton(backgroundColor: AppTheme.Main.Color.pickUpBackground, image: AppTheme.Main.Image.pickUp)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()

    lazy var uiPicker: UIPickerView = {
        let uiPicker = UIPickerView()
        uiPicker.translatesAutoresizingMaskIntoConstraints = false
        return uiPicker
    }()

    // MARK: - LifeCycle
    init(viewModel: RuleCreatorViewModelProtocol = RuleCreatorViewModel(bookService: AppDependencies.shared.bookService)) {
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
        navigationItem.rightBarButtonItem = doneButton
    }

    // MARK: - Setup
    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Texts.libraryTableViewCell)
        tableView.dataSource = self

        uiPicker.dataSource = self
        uiPicker.delegate = self

        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(uiPicker)

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

            uiPicker.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: verticalPadding),
            uiPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalPadding),
            uiPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalPadding),
            uiPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalPadding),
        ])
    }

    // MARK: - Internal Methods
    private func loadBooks() {
        self.addButton.isHidden = true
        viewModel.fetchBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
                self.uiPicker.reloadAllComponents()
                self.addButton.isHidden = false
            case .failure(let failure):
                print("Error getting books: \(failure)")
            }
        }
    }

    // MARK: - Actions
    @objc private func doneTapped() {
        let ruleName = buildRuleName()
        viewModel.addRule(ruleName, books: selectedBooks, isActive: true) { result in
            switch result {
            case .success(let success):
                print("Success \(success)")
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("Error adding rule: \(error)")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @objc private func addTapped() {
        guard let selectedBook = self.selectedBook else {
            if let firstBook = self.books.first {
                self.selectedBooks.append(firstBook)
                tableView.reloadData()
            }
            return
        }
        self.selectedBooks.append(selectedBook)
        tableView.reloadData()
    }

    private func buildRuleName() -> String {
        return selectedBooks.compactMap { $0.name }.joined(separator: " ")
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

// MARK: - UIPickerViewDataSource
extension RuleCreatorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return books.count
    }
}

// MARK: - UIPickerViewDelegate
extension RuleCreatorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return books[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedBook = books[row]
    }
}
