//
//  Environment.swift
//  GenGen
//
//  Created by Ceren Majoor on 05/11/2024.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Bundle.main.infoDictionary not found")
        }
        return dict
    }()

    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API_KEY not in info.plist")
        }
        return apiKeyString
    }()
}
