//
//  LibraryRouter.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 03/04/2023.
//

import Foundation
import CoreData

protocol LibraryRouting {
    func didSelectBook(in viewController: LibraryViewController, book: Book)
}

class LibraryRouter: LibraryRouting {
    func didSelectBook(in viewController: LibraryViewController, book: Book) {
        let bookViewController = BookViewController(book: book)
        viewController.navigationController?.pushViewController(bookViewController, animated: true)
    }
}
