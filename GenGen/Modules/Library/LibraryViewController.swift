//
//  LibraryViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit
import CoreData

class LibraryViewController: BaseViewController {
    
    // MARK: - Dependencies
    private var viewModel: BookProvider
    private var router: LibraryRouting
    var books: [Book] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    init(viewModel: BookProvider = LibraryViewModel(), router: LibraryRouting = LibraryRouter()) {
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
        viewModel.getBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.books = success
                self.tableView.reloadData()
            case .failure(let failure):
                print("Error getting books \(failure)")
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
            if self.viewModel.addBook(bookName: bookName) {
                loadBooks()
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
}
