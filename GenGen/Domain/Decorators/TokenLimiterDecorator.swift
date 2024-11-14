//
//  TokenLimiterDecorator.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

class TokenLimiterDecorator: GenerateTextWithOpenAIUseCaseProtocol {
    private let wrapped: GenerateTextWithOpenAIUseCaseProtocol
    private let tokenLimit: Int
    
    init(wrapping wrapped: GenerateTextWithOpenAIUseCaseProtocol, tokenLimit: Int) {
        self.wrapped = wrapped
        self.tokenLimit = tokenLimit
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let modifiedPrompt = "\(prompt) (Use up to \(tokenLimit) tokens)"
        
        wrapped.execute(for: modifiedPrompt, completion: completion)
    }
}
