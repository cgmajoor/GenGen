//
//  Rule.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import Foundation

/**
 A Rule has ordered list of books
 -  Ex1: A rule can be defined as [size, color, food] = giant blue banana
 -  Ex2: Another rule can be defined as [color, action, animal] = pink jumping panda
 */
struct Rule {
    var active: Bool
    var books: [Book]
}
