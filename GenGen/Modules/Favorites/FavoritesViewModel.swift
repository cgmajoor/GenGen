//
//  FavoritesViewModel.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func fetchFavorites(_ completion: @escaping (Result<[Favorite], Error>) -> Void)
    func addFavorite(favoriteTitle: String, _ completion: @escaping (Result<[Favorite], Error>) -> Void)
    func deleteFavorite(_ favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    // MARK: - Dependencies
    private let getAllFavoritesUseCase: GetAllFavoritesUseCaseProtocol
    private let addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol
    private let deleteFavoriteUseCase: DeleteFavoriteUseCaseProtocol
    private(set) var favorites: [Favorite] = []

    
    init(getAllFavoritesUseCase: GetAllFavoritesUseCaseProtocol,
             addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol,
             deleteFavoriteUseCase: DeleteFavoriteUseCaseProtocol) {
            self.getAllFavoritesUseCase = getAllFavoritesUseCase
            self.addFavoriteUseCase = addFavoriteUseCase
            self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }

    // MARK: - Methods
    func fetchFavorites(_ completion: @escaping (Result<[Favorite], Error>) -> Void) {
        getAllFavoritesUseCase.execute { [weak self] result in
            switch result {
            case .success(let favorites):
                self?.favorites = favorites
                completion(.success(favorites))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addFavorite(favoriteTitle: String, _ completion: @escaping (Result<[Favorite], Error>) -> Void) {
            addFavoriteUseCase.execute(favoriteTitle: favoriteTitle) { [weak self] result in
                switch result {
                case .success(let favorite):
                    if let newFavorite = favorite {
                        self?.favorites.append(newFavorite)
                        completion(.success(self?.favorites ?? []))
                    } else {
                        completion(.success(self?.favorites ?? [])) // No action if duplicate
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    func deleteFavorite(_ favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void) {
         deleteFavoriteUseCase.execute(favorite: favorite) { [weak self] result in
             switch result {
             case .success:
                 self?.favorites.removeAll { $0 == favorite }
                 completion(.success(()))
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }

}
