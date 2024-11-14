//
//  GenerateViewModel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol Generating {
    var generatedStr: String { get }
    var gptTypes: [GPTType] { get }
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void)
    func generate(_ completion: @escaping (Result<String, Error>) -> Void)
    func addFavorite(_ text: String, completion: @escaping (Result<Void, Error>) -> Void)
    func generateTextWithOpenAI(for prompt: String?, item: Int, completion: @escaping (Result<String, Error>) -> Void)
}

// MARK: - Generator
class GenerateViewModel: Generating {

    // MARK: - Properties
    var generatedStr: String = ""
    var activeRules: [Rule] = []
    let gptTypes: [GPTType] = [.ai2Cents, .rhyme, .joke, .mnemonic, .eco, .calm, .careerAdvisor]

    private let getActiveRulesUseCase: GetActiveRulesUseCaseProtocol
    private let generateWithRulesUseCase: GenerateWithRulesUseCaseProtocol
    private let getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol
    private let getWordsInBookUseCase: GetWordsInBookUseCaseProtocol
    private let addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol
    private let generateTextWithOpenAIUseCase: GenerateTextWithOpenAIUseCaseProtocol

    // MARK: - Initialization
    init(
        getActiveRulesUseCase: GetActiveRulesUseCaseProtocol = GetActiveRulesUseCase(),
        generateWithRulesUseCase: GenerateWithRulesUseCaseProtocol = GenerateWithRulesUseCase(),
        getBookIDsInRuleUseCase: GetBookIDsInRuleUseCaseProtocol = GetBookIDsInRuleUseCase(),
        getWordsInBookUseCase: GetWordsInBookUseCaseProtocol = GetWordsInBookUseCase(),
        addFavoriteUseCase: AddFavoriteIfNotExistsUseCaseProtocol = AddFavoriteIfNotExistsUseCase(),
        generateTextWithOpenAIUseCase: GenerateTextWithOpenAIUseCaseProtocol = GenerateAI2CentsUseCase()
    ) {
        self.getActiveRulesUseCase = getActiveRulesUseCase
        self.generateWithRulesUseCase = generateWithRulesUseCase
        self.getBookIDsInRuleUseCase = getBookIDsInRuleUseCase
        self.getWordsInBookUseCase = getWordsInBookUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.generateTextWithOpenAIUseCase = generateTextWithOpenAIUseCase
    }

    // MARK: - Methods
    func getActiveRules(_ completion: @escaping (Result<[Rule], Error>) -> Void) {
        getActiveRulesUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let activeRules):
                self.activeRules = activeRules
                completion(.success(activeRules))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func generate(_ completion: @escaping (Result<String, Error>) -> Void) {
        generateWithRulesUseCase.execute(activeRules: activeRules) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let generatedText):
                self.generatedStr = generatedText
                completion(.success(generatedText))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func generateTextWithOpenAI(for prompt: String?, item: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let selectedGPTType = self.gptTypes[item]

        var selectedUseCase: GenerateTextWithOpenAIUseCaseProtocol = selectedGPTType.useCase
        selectedUseCase = TokenLimiterDecorator(wrapping: selectedUseCase, tokenLimit: selectedGPTType.tokenLimit)
        selectedUseCase = ChildSafetyDecorator(wrapped: selectedUseCase)
        selectedUseCase = PrefaceRemoverDecorator(wrapped: selectedUseCase)

        selectedUseCase.executeWithFallback(for: prompt) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let generatedText):
                completion(.success(generatedText))
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }

    func addFavorite(_ text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        addFavoriteUseCase.execute(favoriteTitle: text) { result in
            switch result {
            case .success(let favorite):
                if favorite != nil {
                    print("Favorite added successfully")
                } else {
                    print("Favorite already exists")
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
