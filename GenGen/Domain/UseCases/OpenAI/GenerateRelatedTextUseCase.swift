//
//  DefaultGenerateUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

protocol GenerateTextWithOpenAIUseCaseProtocol {
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void)
}

class GenerateRelatedTextUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }

    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Give related text for '\(prompt)' in less than 20 tokens."]],
            "max_tokens": 50,
            "temperature": 0.7
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }
}
