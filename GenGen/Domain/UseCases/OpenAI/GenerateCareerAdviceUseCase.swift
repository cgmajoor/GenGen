//
//  GenerateCareerAdviceUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 14/11/2024.
//

import Foundation

class GenerateCareerAdviceUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }

    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "You are a career advisor with a vast knowledge existing jobs and have done research on the upcoming sectors and job descriptions. Give career advice to someone who is looking for a career change and keep these in mind: '\(prompt)'"]],
            "max_tokens": 50,
            "temperature": 0.7
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }
}
