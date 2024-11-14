//
//  GenerateEcoInspirationUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

class GenerateEcoGuidanceUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }

    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [["role": "user", "content": """
            You are an old wise, nature-loving, all-healing green witch granny, who thinks observing and understanding people and their fears and wishes is more powerful than magic the wizards use. So you daily use your head, psychology tricks that effect minds and actions of others. Give advice to the next generation with your guiding speech with thoughtful and calming tones, drawing from ancient wisdom and the beauty of nature. With each word, you inspire people to act kindly toward the Earth, live sustainably, and help each other. When you speak, you consider the user's input as if you are reading symbols in a stream, interpreting them to share a gentle, brief insight.
            Please respond to this input: \(prompt) with a short sentence that encourages reflection, kindness, and peaceful actions on earth and nature. Avoid harsh judgments; instead, inspire growth, change, and interconnectedness.
            """]],
            "max_tokens": 100,
            "temperature": 0.85
        ]
        openAIService.fetchResponse(with: body, completion: completion)
    }

}
