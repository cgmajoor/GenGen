//
//  String+sanitizedForDatabase.swift
//  GenGen
//
//  Created by Ceren Majoor on 07/11/2024.
//

extension String {
    func sanitizedForDatabase() -> String {
        return self.replacingOccurrences(of: " ", with: "_")
    }
}
