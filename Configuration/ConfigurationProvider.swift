//
//  ConfigurationProvider.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

protocol ConfigurationProviderProtocol {
    var openAIAPIKey: String { get }
    var openAIBaseURL: URL { get }
}

class ConfigurationProvider: ConfigurationProviderProtocol {
    var openAIAPIKey: String {
        return Environment.apiKey
    }

    var openAIBaseURL: URL {
        return URL(string: "https://api.openai.com/v1/chat/completions")!
    }
}
