//
//  GetAllFavoritesUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

protocol GetAllFavoritesUseCaseProtocol {
    func execute(completion: @escaping (Result<[Favorite], Error>) -> Void)
}

class GetAllFavoritesUseCase: GetAllFavoritesUseCaseProtocol {
    private let favoriteService: FavoriteServiceProtocol

    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }

    func execute(completion: @escaping (Result<[Favorite], Error>) -> Void) {
        favoriteService.getFavorites(completion: completion)
    }
}
