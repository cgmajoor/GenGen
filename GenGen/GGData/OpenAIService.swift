//
//  OpenAIService.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//
import Foundation

protocol OpenAIServiceProtocol {
    func fetchResponse(prompt: String, completion: @escaping (Result<String, Error>) -> Void)
}

class OpenAIService: OpenAIServiceProtocol {
    private let configuration: ConfigurationProviderProtocol

    init(configuration: ConfigurationProviderProtocol = ConfigurationProvider()) {
        self.configuration = configuration
    }

    func fetchResponse(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = configuration.openAIBaseURL
        let apiKey = configuration.openAIAPIKey

        let request = URLRequestBuilder(url: url)
            .setMethod("POST")
            .addHeader(key: "Content-Type", value: "application/json")
            .addHeader(key: "Authorization", value: "Bearer \(apiKey)")
            .setBody([
                "model": "gpt-4o-mini",
                "messages": [["role": "user", "content": "Give related text for '\(prompt)' in less than 20 tokens."]],
                "max_tokens": 100,
                "temperature": 0.5
            ])
            .build()

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = jsonObject["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion(.failure(NSError(domain: "Parsing error", code: 500, userInfo: nil)))
                return
            }

            completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
        }.resume()
    }
}
