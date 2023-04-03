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
    private var router: LibraryRouting
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
        self.books = viewModel.fetchBooks()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @objc private func addTapped() {
        print("add tapped")
        GGPromptAlert.createAlert(title: Texts.addNewBookAlertTitle, message: nil, in: self) { userInput in
            print("userInput: \(userInput)")
        }
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
        router.didSelectBook(in: self, book: books[indexPath.row])
    }
}
