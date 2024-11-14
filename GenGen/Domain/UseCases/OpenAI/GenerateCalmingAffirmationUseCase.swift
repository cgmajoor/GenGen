//
//  GenerateCalmingTextUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

import Foundation

class GenerateCalmingAffirmationUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }

    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": """
            You are a cozy, ancient witch, wise in the ways of nature, life, and all living beings. Your words are gentle, inspiring, and calming, meant to guide others to find serenity, confidence, and joy within themselves. 
            Speak as if you are offering an affirmation or calming insight to gently encourage peace, balance, and self-acceptance. Let your response connect to this text: '\(prompt)' and offer a short, soothing thought to make the listener feel grounded, calm, and at one with life.
            """]],
            "max_tokens": 100,
            "temperature": 0.85
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }

}
