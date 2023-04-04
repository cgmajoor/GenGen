//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol Generating {
    var generatedStr: String { get }
    var activeRule: Rule? { get }
    
    func getRandomActiveRule(_ completion: @escaping (Result<Rule?, Error>) -> Void)
    func generate(_ completion: @escaping (Result<String, Error>) -> Void)
}

// MARK: - Generator
class GenerateViewModel: Generating {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Properties
    var generatedStr: String = ""
    var activeRule: Rule?
    
    // MARK: - Initialization
    convenience init(with activeRule: Rule?) {
        self.init()
        self.activeRule = activeRule
    }
    
    // MARK: - Methods
    func getRandomActiveRule(_ completion: @escaping (Result<Rule?, Error>) -> Void) {
        let request: NSFetchRequest<Rule> = Rule.fetchRequest()
        request.predicate = NSPredicate(format: "active == true")
        request.fetchLimit = 1
        do {
            let rules = try context.fetch(request)
            let randomRule = rules.randomElement()
            completion(.success(randomRule))
        } catch {
            completion(.failure(error))
        }
    }
    
    func generate(_ completion: @escaping (Result<String, Error>) -> Void) {
        self.getRandomActiveRule { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                guard let activeRule = success else { return }
                self.generatedStr = activeRule.bookOrder?
                    .map { $0 as! Book }
                    .compactMap{ book -> String? in
                        guard let words = book.words,
                              let randomWord = words.anyObject() as? Word else {
                            return ""
                        }
                        return randomWord.title
                    }.joined(separator: " ") ?? ""
                completion(.success(self.generatedStr))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
