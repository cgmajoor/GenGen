//
//  DoesFavoriteExistUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

protocol DoesFavoriteExistUseCaseProtocol {
    func execute(favoriteTitle: String) -> Bool
}

class DoesFavoriteExistUseCase: DoesFavoriteExistUseCaseProtocol {
    private let favoriteService: FavoriteServiceProtocol

    init(favoriteService: FavoriteServiceProtocol = AppDependencies.shared.favoriteService) {
        self.favoriteService = favoriteService
    }

    func execute(favoriteTitle: String) -> Bool {
        return favoriteService.favoriteExists(with: favoriteTitle)
    }
}
