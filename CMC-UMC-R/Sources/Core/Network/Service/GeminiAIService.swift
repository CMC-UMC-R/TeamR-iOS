//
//  GeminiAIService.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/23/25.
//

import Foundation
import Moya

struct GenerateWordResponse: Codable {
    let word: String
    let description: String
}


class GeminiAIService {
    private let jsonDecoder = JSONDecoder()
    let provider = MoyaProvider<GeminiAITarget>(plugins: [MoyaLoggingPlugin()])
}

extension GeminiAIService {
    func generateWord(geminiCategoryType: GeminiCategoryType) async throws -> GenerateWordResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.wordsGenerate(geminiCategoryType)) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(GenerateWordResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("generateWord() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
