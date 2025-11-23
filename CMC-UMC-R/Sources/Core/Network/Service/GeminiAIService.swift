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

struct VerifyResponse: Codable {
    let status: String  // "APPROVED" or other status
    let reason: String
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
    
    /// 사진 인증 검증 API
    /// - Returns: VerifyResponse with status "APPROVED" if successful
    func verifyMission(word: String, imageData: Data) async throws -> VerifyResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.verify(word, imageData)) { result in
                switch result {
                case let .success(response):
                    do {
                        let verifyResponse = try self.jsonDecoder.decode(VerifyResponse.self, from: response.data)
                        continuation.resume(returning: verifyResponse)
                    } catch {
                        Log.network("verifyMission() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    Log.network("verifyMission() 네트워크 실패", error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
