//
//  BookViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 03/04/2023.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: - Dependencies
    var book: Book

    // MARK: - UI
    var headerLabel: GGLabel

    // MARK: - Lifecycle
    init(book: Book) {
        self.book = book
        self.headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.library,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: book.name)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItems()
        setup()
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
    }

    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
    }
}
