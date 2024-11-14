//
//  GenerateTextWithOpenAIUseCaseProtocol.swift
//  GenGen
//
//  Created by Ceren Majoor on 13/11/2024.
//

protocol GenerateTextWithOpenAIUseCaseProtocol {
    func execute(for prompt: String, completion: @escaping (Result<String, Error>) -> Void)
}

extension GenerateTextWithOpenAIUseCaseProtocol {
    func executeWithFallback(for prompt: String?, completion: @escaping (Result<String, Error>) -> Void) {
        if let prompt = prompt, !prompt.isEmpty {
            execute(for: prompt, completion: completion)
        } else {
            executeFallback(completion: completion)
        }
    }

    private func executeFallback(completion: @escaping (Result<String, Error>) -> Void) {
        let fallbackPrompt = getFallbackPrompt()
        execute(for: fallbackPrompt, completion: completion)
    }

    private func getFallbackPrompt() -> String {
        switch self {
        case is GenerateAI2CentsUseCase:
            return "Give your 2 cents as a general life advice for living good and happy."
        case is GenerateRhymeUseCase:
            return "Tell me 2 words or phrases that rhyme."
        case is GenerateJokeUseCase:
            return "Tell me a general funny joke that is child-friendly but still funny for all ages.(20 tokens or less)"
        case is GenerateMnemonicUseCase:
            return "Provide a well known mneumonic phrase to teach me something."
        case is GenerateEcoGuidanceUseCase:
            return "Share an eco-friendly tip or inspiring guidance."
        case is GenerateCalmingAffirmationUseCase:
            return "Provide a calming affirmation for general well-being."
        case is GenerateCareerAdviceUseCase:
            return "Provide a career advice for doing what you love that will help the world be a better place."
        default:
            return "Provide a generic inspiration message."
        }
    }
}

