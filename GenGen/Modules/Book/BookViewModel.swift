//
//  BookViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 04/04/2023.
//

import UIKit
import CoreData

protocol BookViewModelProtocol {
    func fetchBook(_ book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void)
    func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void)
}

class BookViewModel: BookViewModelProtocol {

    // MARK: - Properties
    let coreDataStack: CoreDataStack
    private let context: NSManagedObjectContext
    private var book: Book?
    private var words: [Word]

    init(coreDataStack: CoreDataStack = CoreDataStack(), book: Book? = nil, words: [Word] = []) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.persistentContainer.viewContext
        self.book = book
        self.words = words
    }

    // MARK: - Methods
    func fetchBook(_ book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void) {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try context.fetch(request)
            guard let fetchedBook = books.first(where: { $0.name == book.name }) else {
                return
            }
            self.book = fetchedBook
            fetchWords(for: fetchedBook) { fetchWordsResult in
                switch fetchWordsResult {
                case .success(let fetchedWords):
                    completion(.success((fetchedBook, fetchedWords)))
                case .failure(_):
                    return
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    private func fetchWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void) {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
            request.predicate = NSPredicate(format: "parentBook == %@", book)

        do {
            self.words = try context.fetch(request)
            completion(.success(self.words))
        } catch {
            completion(.failure(error))
        }
    }

    func addWord(_ wordTitle: String, to book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void) {
        let newWord = Word(context: context)
        newWord.title = wordTitle
        newWord.parentBook?.name = book.name
        self.words.append(newWord)
        book.addToWords(newWord)
        
        do {
            try context.save()
            completion(.success((book, words)))
        } catch {
            completion(.failure(error))
        }
    }
}
