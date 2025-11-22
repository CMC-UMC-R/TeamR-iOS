//
//  GeminiAIAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum GeminiAIAPI {
    case verify             /// 미션 인증 검증
    case wordsGenerate      /// 미션 단어 생성
    case wordsRegenerate    /// 미션 단어 재생성(다른 단어)
    
    var path: String {
        switch self {
        case .verify:
            "gemini/verify"
        case .wordsGenerate:
            "gemini/words/generate"
        case .wordsRegenerate:
            "gemini/words/regenerate"
        }
    }
}
