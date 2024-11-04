//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit
import CoreData

class LibraryViewController: BaseViewController {
    
    // MARK: - Properties
    var books: [Book] = []
    private var viewModel: LibraryViewModelProtocol
    private var router: LibraryRouting
    
    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.library,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.libraryNavigationTitle)
    
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
    
    // MARK: - LifeCycle
    init(viewModel: LibraryViewModelProtocol = LibraryViewModel(), router: LibraryRouting = LibraryRouter()) {
        self.viewModel = viewModel
        self.router = router
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
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: Texts.libraryTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }
    
    // MARK: - Internal Methods
    private func loadBooks() {
        self.addButton.isHidden = true
        viewModel.fetchBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
                self.tableView.reloadData()
                self.addButton.isHidden = false
            case .failure(let failure):
                print("Error getting books: \(failure)")
            }
        }
    }
    
    // MARK: - Actions
    @objc private func addTapped() {
        GGPromptAlert.createAlert(title: Texts.addNewBookAlertTitle, message: nil, in: self) { [weak self] bookNameInput in
            guard let self = self else { return }
            guard let bookName = bookNameInput else {
                return
            }
            viewModel.addBook(bookName: bookName) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let books):
                    self.books = books
                    self.tableView.reloadData()
                case .failure(let failure):
                    print("Error adding book: \(failure)")
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension LibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.libraryTableViewCell, for: indexPath) as? LibraryTableViewCell,
              let bookName = books[indexPath.row].name else {
            return UITableViewCell()
        }
        cell.configure(bookName: bookName)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.didSelectBook(in: self, book: books[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let bookToDelete = self.books[indexPath.row]
            
            self.viewModel.deleteBookWithDependencies(bookToDelete) { result in
                switch result {
                case .success:
                    self.books.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                case .failure(let error):
                    print("Error deleting book with dependencies: \(error)")
                    completionHandler(false)
                }
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
