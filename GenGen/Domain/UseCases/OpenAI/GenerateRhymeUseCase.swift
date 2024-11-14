//
//  GenerateRhymingPoemUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

class GenerateRhymeUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol
    
    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": "Give a rhyming poem of 4 or 8 lines with rhymescheme: AABB or ABAB or AABA, using words: '\(prompt)' In the language of the words given."]],
            "max_tokens": 80,
            "temperature": 0.6
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }
}
