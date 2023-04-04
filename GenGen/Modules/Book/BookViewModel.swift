//
//  BookViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 04/04/2023.
//

import UIKit
import CoreData

protocol BookViewModelProtocol {
    func getBook(_ book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void)
    func addWord(_ wordTitle: String, to book: Book) -> Bool
}

class BookViewModel: BookViewModelProtocol {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Properties
    private var book: Book?
    private var words: [Word] = []

    // MARK: - Methods
    func getBook(_ book: Book, _ completion: @escaping (Result<(Book, [Word]), Error>) -> Void) {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try context.fetch(request)
            guard let fetchedBook = books.first(where: { $0.name == book.name }) else {
                return
            }
            self.book = fetchedBook
            getWords(for: fetchedBook) { getWordsResult in
                switch getWordsResult {
                case .success(let success):

                    completion(.success((fetchedBook, success)))
                case .failure(_):
                    return
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func getWords(for book: Book, _ completion: @escaping (Result<[Word], Error>) -> Void) {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
            request.predicate = NSPredicate(format: "parentBook == %@", book)

        do {
            self.words = try context.fetch(request)
            completion(.success(self.words))
        } catch {
            completion(.failure(error))
        }
    }

    func addWord(_ wordTitle: String, to book: Book) -> Bool {
        let newWord = Word(context: context)
        newWord.title = wordTitle
        newWord.parentBook?.name = book.name
        self.words.append(newWord)
        book.addToWords(newWord)
        
        do {
            try context.save()
        } catch {
            print("Error adding word")
        }
        return true
    }
}
