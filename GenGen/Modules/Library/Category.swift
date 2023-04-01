//
//  Category.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

/**
 A caregory has items array of String that has 0 or more words in it
 -  Ex1: A color category might have items such as: ["pink", "green", "blue"]
 -  Ex2: A size category might have items such as ["tiny", "giant"]
 -  Ex3: An animal category might have items such as ["cat", "panda", "turtle"]
 */
struct Category {
    var name: String
    var words: [String]
}
