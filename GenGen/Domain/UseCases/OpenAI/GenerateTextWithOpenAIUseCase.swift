//
//  OpenAIUseCase.swift
//  GenGen
//
//  Created by Ceren Majoor on 12/11/2024.
//

import Foundation

protocol GenerateTextWithOpenAIUseCaseProtocol {
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void)
}

class GenerateTextWithOpenAIUseCase: GenerateTextWithOpenAIUseCaseProtocol {
    private let openAIService: OpenAIServiceProtocol

    init(openAIService: OpenAIServiceProtocol = OpenAIService()) {
        self.openAIService = openAIService
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAIService.fetchResponse(prompt: prompt, completion: completion)
    }
}
