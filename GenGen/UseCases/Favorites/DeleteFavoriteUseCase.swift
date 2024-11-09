//
//  DeleteFavoriteUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

protocol DeleteFavoriteUseCaseProtocol {
    func execute(favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void)
}

class DeleteFavoriteUseCase: DeleteFavoriteUseCaseProtocol {
    private let favoriteService: FavoriteServiceProtocol

    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }

    func execute(favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void) {
        favoriteService.deleteFavorite(favorite, completion: completion)
    }
}
