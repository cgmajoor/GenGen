//
//  PrefaceRemoverDecorator.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

class PrefaceRemoverDecorator: GenerateTextWithOpenAIUseCaseProtocol {
    private let wrapped: GenerateTextWithOpenAIUseCaseProtocol
    
    init(wrapped: GenerateTextWithOpenAIUseCaseProtocol) {
        self.wrapped = wrapped
    }
    
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let modifiedPrompt = "\(prompt) (Respond directly without any prefatory words or acknowledgments.)"
        
        wrapped.execute(for: modifiedPrompt, completion: completion)
    }
}
