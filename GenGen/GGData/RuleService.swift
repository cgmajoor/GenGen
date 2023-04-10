//
//  RuleService.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//


import Foundation
import CoreData

protocol RuleServiceProtocol {
    func getRules(_ completion: @escaping (Result<[Rule], Error>) -> Void)
}

public class RuleService: RuleServiceProtocol {
    // MARK: - Properties
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext

    // MARK: - Initialization
    public init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
    }
}

extension RuleService {
    public func getRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
        let request: NSFetchRequest<Rule> = Rule.fetchRequest()
        do {
            let rules = try context.fetch(request)
            completion(.success(rules))
        } catch {
            completion(.failure(error))
        }
    }
}
