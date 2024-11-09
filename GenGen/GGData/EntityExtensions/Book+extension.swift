//
//  Book+extension.swift
//  GenGen
//
//  Created by Ceren Majoor on 08/11/2024.
//

import Foundation

extension Book {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}
