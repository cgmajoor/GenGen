//
//  ChildSafetyDecorator.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

class ChildSafetyDecorator: GenerateTextWithOpenAIUseCaseProtocol {
    private let wrapped: GenerateTextWithOpenAIUseCaseProtocol
    
    init(wrapped: GenerateTextWithOpenAIUseCaseProtocol) {
        self.wrapped = wrapped
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let modifiedPrompt = "\(prompt) (Ensure the response is child-friendly and safe.)"
        
        wrapped.execute(for: modifiedPrompt, completion: completion)
    }
}
