//
//  FavoritesViewController.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import UIKit
import CoreData

class FavoritesViewController: BaseViewController {

    // MARK: - Properties
    var favorites: [Favorite] = []
    private var viewModel: FavoritesViewModelProtocol

    // MARK: - UI
    lazy var headerLabel = GGLabel(textColor: AppTheme.Navigation.Color.favorites,
                                   font:AppTheme.Navigation.FontStyle.title,
                                   fullText: Texts.favoritesNavigationTitle)

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
    init(viewModel: FavoritesViewModelProtocol = FavoritesViewModel(
        getAllFavoritesUseCase: GetAllFavoritesUseCase(favoriteService: AppDependencies.shared.favoriteService),
        addFavoriteUseCase: AddFavoriteIfNotExistsUseCase(favoriteService: AppDependencies.shared.favoriteService),
        deleteFavoriteUseCase: DeleteFavoriteUseCase(favoriteService: AppDependencies.shared.favoriteService)
    )) {
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

        NotificationCenter.default.addObserver(self, selector: #selector(loadFavorites), name: .favoritesUpdated, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesUpdated, object: nil)
    }

    // MARK: - Configurations
    private func configureNavigationItems() {
        self.navigationItem.titleView = headerLabel
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = AppTheme.Main.Color.buttonBackground
    }

    private func setup() {
        view.backgroundColor = AppTheme.Main.Color.background
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: Texts.favoritesTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.embedToSafeArea(view: tableView)
    }

    // MARK: - Internal Methods
    @objc private func loadFavorites() {
        viewModel.fetchFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                self.tableView.reloadData()
                self.addButton.isHidden = false
            case .failure(let failure):
                print("Error getting books \(failure)")
            }
        }
    }

    // MARK: - Actions
    @objc private func addTapped() {
        GGPromptAlert.createAlert(title: Texts.addNewFavoriteAlertTitle, message: nil, in: self) { [weak self] favoriteTitleInput in
            guard let self = self else { return }
            guard let favoriteTitle = favoriteTitleInput else {
                return
            }
            viewModel.addFavorite(favoriteTitle: favoriteTitle) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let favorites):
                    self.favorites = favorites
                    self.tableView.reloadData()
                case .failure(let failure):
                    print("Error adding book: \(failure)")
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Texts.favoritesTableViewCell, for: indexPath) as? FavoritesTableViewCell,
              let favoriteTitle = favorites[indexPath.row].title else {
            return UITableViewCell()
        }
        cell.configure(favoriteTitle: favoriteTitle)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let favoriteToDelete = self.favorites[indexPath.row]

            self.viewModel.deleteFavorite(favoriteToDelete) { result in
                switch result {
                case .success:
                    self.favorites.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                case .failure(let error):
                    print("Error deleting favorite: \(error)")
                    completionHandler(false)
                }
            }
        }

        let shareAction = UIContextualAction(style: .normal, title: "Share") { [weak self] (_, _, completionHandler) in
            self?.shareSelectedRow(at: indexPath)
            completionHandler(true)
        }

        shareAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
}

private extension FavoritesViewController {
    func shareSelectedRow(at indexPath: IndexPath) {
        guard let selectedFavorite = favorites[indexPath.row].title else { return }

        let textToShare = selectedFavorite + Texts.downloadGenGenText

        let logo = AppTheme.Main.Image.downloadGenGen

        let activityViewController = UIActivityViewController(activityItems: [textToShare, logo], applicationActivities: nil)

        present(activityViewController, animated: true, completion: nil)
    }
}
