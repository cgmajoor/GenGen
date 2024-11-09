//
//  AddFavoriteIfNotExistsUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

protocol AddFavoriteIfNotExistsUseCaseProtocol {
    func execute(favoriteTitle: String, completion: @escaping (Result<Favorite?, Error>) -> Void)
}

class AddFavoriteIfNotExistsUseCase: AddFavoriteIfNotExistsUseCaseProtocol {
    private let favoriteService: FavoriteServiceProtocol

    init(favoriteService: FavoriteServiceProtocol = AppDependencies.shared.favoriteService) {
        self.favoriteService = favoriteService
    }

    func execute(favoriteTitle: String, completion: @escaping (Result<Favorite?, Error>) -> Void) {
        if !favoriteService.favoriteExists(with: favoriteTitle) {
            favoriteService.addFavorite(favoriteTitle) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let favorite):
                    completion(.success(favorite))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(nil))
        }
    }
}
