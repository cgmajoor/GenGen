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
    var generatedStr: String = ""

    func generate() {
        generatedStr = "something"
        print("generated: \(generatedStr)")
    }
}