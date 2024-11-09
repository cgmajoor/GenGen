//
//  RuleService.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import Foundation
import CoreData

public protocol RuleServiceProtocol {
    func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Rule, Error>) -> Void)
    func getRules(activeOnly: Bool, _ completion: @escaping (Result<[Rule], Error>) -> Void)
    func update(_ rule: Rule) -> Rule?
    func deleteRule(_ rule: Rule, _ completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAllRulesContaining(book: Book, completion: @escaping (Result<Void, Error>) -> Void)
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
    public func addRule(_ ruleName: String, books: [Book], isActive: Bool, _ completion: @escaping (Result<Rule, Error>) -> Void) {
        let rule = Rule(context: context)
        rule.name = ruleName
        rule.active = isActive
        rule.bookIDs = books.compactMap { $0.id } as NSArray
        books.forEach {
            rule.addToBookOrder($0)
        }

        do {
            try coreDataStack.saveContext()
            completion(.success(rule))
        } catch {
            completion(.failure(error))
        }
    }

    public func getRules(activeOnly: Bool = false, _ completion: @escaping (Result<[Rule], Error>) -> Void) {
        let request: NSFetchRequest<Rule> = Rule.fetchRequest()
        if activeOnly {
            request.predicate = NSPredicate(format: "active == true")
        }
        do {
            let rules = try context.fetch(request)
            completion(.success(rules))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func update(_ rule: Rule) -> Rule? {
        do {
            try coreDataStack.saveContext()
            return rule
        } catch {
            return nil
        }
    }
    
    public func deleteRule(_ rule: Rule, _ completion: @escaping (Result<Void, Error>) -> Void) {
        context.delete(rule)
        do {
            try coreDataStack.saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func deleteAllRulesContaining(book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let bookID = book.id else {
            completion(.failure(RuleError.invalidBookID))
            return
        }

        let request: NSFetchRequest<Rule> = Rule.fetchRequest()

        do {
            let rules = try context.fetch(request)
            for rule in rules {
                if let bookIDs = rule.bookIDs as? [UUID], bookIDs.contains(bookID) {
                    context.delete(rule)
                }
            }
            try coreDataStack.saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

enum RuleError: Error {
    case invalidBookID
}
