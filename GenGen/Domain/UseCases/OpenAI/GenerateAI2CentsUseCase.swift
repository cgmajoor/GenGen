//
//  DefaultGenerateUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

class GenerateAI2CentsUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol
    
    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Give your 2 cents on this text: '\(prompt)'"]],
            "max_tokens": 50,
            "temperature": 0.7
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }
}
