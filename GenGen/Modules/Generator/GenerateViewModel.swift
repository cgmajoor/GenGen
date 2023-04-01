//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

protocol Generating {
    var generatedStr: String { get }

    func generate()
}

class GenerateViewModel: Generating {

    // MARK: - Properties
    var generatedStr: String = ""
    var rules: [Rule]

    // MARK: - Initialization
    init(rules: [Rule] = []){
        self.rules = rules
    }

    func generate() {
        generatedStr = rules.filter(\.active)
            .randomElement()?
            .categories.compactMap { category in
                category.words.randomElement()
            }.joined(separator: " ") ?? ""
    }
}
