//
//  GenerateJokeUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

class GenerateJokeUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }

    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Create a joke using pun '\(prompt)' using less than 100 tokens."]],
            "max_tokens": 100,
            "temperature": 0.9
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }
}
