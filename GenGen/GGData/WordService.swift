//
//  WordService.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import Foundation
import CoreData

protocol WordServiceProtocol {
    func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, Word), Error>) -> Void)
    func getWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void)
}

public class WordService: WordServiceProtocol {
    // MARK: - Properties
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext

    // MARK: - Initialization
    public init(coreDataStack: CoreDataStack = CoreDataStack()) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
    }
}

extension WordService {
    public func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, Word), Error>) -> Void) {
        let newWord = Word(context: context)
        newWord.title = wordTitle
        newWord.parentBook?.name = book.name

        book.addToWords(newWord)

        do {
            try context.save()
            completion(.success((book, newWord)))
        } catch {
            completion(.failure(error))
        }
    }

    public func getWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void) {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
            request.predicate = NSPredicate(format: "parentBook == %@", book)

        do {
            let words = try context.fetch(request)
            completion(.success(words))
        } catch {
            completion(.failure(error))
        }
    }
}