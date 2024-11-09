//
//  BookViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 03/04/2023.
//

import UIKit
import CoreData

class BookViewController: BaseViewController {

    // MARK: - Properties
    var book: Book
    var words: [Word] = []
    private var viewModel: BookViewModelProtocol
    
    // MARK: - UI
    var headerLabel: GGLabel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: AppTheme.Navigation.Image.add,
                                            style: .plain,
                                            target: self,
                                            action: #selector(addTapped))
        barButtonItem.tintColor = AppTheme.Main.Color.buttonBackground
        return barButtonItem
    }()

    // MARK: - Lifecycle
    init(
        book: Book,
        viewModel: BookViewModelProtocol =
        BookViewModel(
            wordService: AppDependencies.shared.wordService,
            deleteWordUseCase: DeleteWordUseCase(wordService: AppDependencies.shared.wordService)
        )
    ) {
        self.book = book
        self.viewModel = viewModel
        self.headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.library,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: book.name ?? "")
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()

        loadBook()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = AppTheme.Main.Color.buttonBackground
    }

    private func setup() {
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: Texts.bookTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }

    // MARK: - Internal Methods
    private func loadBook() {
        viewModel.fetchWords(for: book) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let words):
                self.words = words
                self.tableView.reloadData()
            case .failure(let failure):
                print("Error getting books \(failure)")
            }
        }
    }

    // MARK: - Actions
    @objc private func addTapped() {
        GGPromptAlert.createAlert(title: Texts.addNewWordAlertTitle, message: nil, in: self) { [weak self] wordInput in
            guard let self = self else { return }
            guard let wordTitle = wordInput else {
                return
            }
            self.viewModel.addWord(wordTitle, to: book) { result in
                switch result {
                case .success(_):
                    self.loadBook()
                case .failure(let failure):
                    print("Failed to add word to book: \(failure)")
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension BookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.bookTableViewCell, for: indexPath) as? BookTableViewCell,
              let wordTitle = words[indexPath.row].title else {
            return UITableViewCell()
        }
        cell.configure(with: wordTitle)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let wordToDelete = self.words[indexPath.row]

            self.viewModel.deleteWord(wordToDelete) { result in
                switch result {
                case .success:
                    self.words.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                case .failure(let error):
                    print("Failed to delete word: \(error)")
                    completionHandler(false)
                }
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
