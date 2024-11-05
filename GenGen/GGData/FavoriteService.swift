//
//  FavoriteService.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation
import CoreData

protocol FavoriteServiceProtocol {
    func getFavorites(completion: @escaping (Result<[Favorite], Error>) -> Void)
    func addFavorite(_ text: String, completion: @escaping (Result<Favorite, Error>) -> Void)
    func deleteFavorite(_ favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void)
    func favoriteExists(with title: String) -> Bool
}

public class FavoriteService: FavoriteServiceProtocol {
    private let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext

    public init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
    }

    public func getFavorites(completion: @escaping (Result<[Favorite], Error>) -> Void) {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            let favorites = try context.fetch(request)
            completion(.success(favorites))
        } catch {
            completion(.failure(error))
        }
    }

    public func addFavorite(_ text: String, completion: @escaping (Result<Favorite, Error>) -> Void) {
        let favorite = Favorite(context: context)
        favorite.title = text
        do {
            try context.save()
            completion(.success(favorite))
        } catch {
            completion(.failure(error))
        }
    }

    public func deleteFavorite(_ favorite: Favorite, completion: @escaping (Result<Void, Error>) -> Void) {
        context.delete(favorite)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    public func favoriteExists(with title: String) -> Bool {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            print("Error checking for favorite existence: \(error)")
            return false
        }
    }
}
