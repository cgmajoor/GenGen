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
    typealias Rule = [String]

    var generatedStr: String = ""
    var rules: [Rule]

    init(rules: [Rule] = []){
        self.rules = rules
    }

    func generate() {
        print("generated: \(generatedStr)")
    }
}
