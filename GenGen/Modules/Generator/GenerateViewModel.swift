//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

// MARK: - Protocol
protocol Generating {
    var generatedStr: String { get }
    var rules: [Rule] { get }

    func fetchRules() -> [Rule]
    func generate() -> String
}

// MARK: - Generator
class GenerateViewModel: Generating {

    // MARK: - Properties
    var generatedStr: String = ""
    var rules: [Rule] = []

    // MARK: - Initialization
    convenience init(with rules: [Rule]) {
        self.init()
        self.rules = rules
    }

    // MARK: - Methods
    func fetchRules() -> [Rule] {
        //TODO: Fetch from somewhere currently testing
        let books = [Book(name: "color", words: ["pink", "blue"]),
                     Book(name: "animal", words: ["panda"])]
        rules = [Rule(active: true, books: books)]
        
        return rules
    }

    func generate() -> String {
        rules = fetchRules()
        generatedStr = rules.filter(\.active)
                            .randomElement()?
                            .books.compactMap { book in
                                book.words.randomElement()
                            }.joined(separator: " ") ?? ""
        return generatedStr
    }
}
