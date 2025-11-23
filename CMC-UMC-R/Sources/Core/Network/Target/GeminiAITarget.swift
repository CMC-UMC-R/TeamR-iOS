//
//  GeminiAITarget.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya
import Alamofire

enum GeminiAITarget {
    case verify(String, Data)             /// 미션 인증 검증
    case wordsGenerate(GeminiCategoryType)      /// 미션 단어 생성
    case wordsRegenerate(GeminiCategoryType)    /// 미션 단어 재생성(다른 단어)
}

extension GeminiAITarget: BaseTargetType {
    var path: String {
        switch self {
        case .verify:
            GeminiAIAPI.verify.path
        case .wordsGenerate:
            GeminiAIAPI.wordsGenerate.path
        case .wordsRegenerate:
            GeminiAIAPI.wordsRegenerate.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .verify:
            return .post
        case .wordsGenerate:
            return .post
        case .wordsRegenerate:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .verify(let word, let imageData):
            // word는 query parameter로, image는 multipart body로 전달
            let formData = MultipartFormData(
                provider: .data(imageData),
                name: "image",
                fileName: "photo.jpg",
                mimeType: "image/jpeg"
            )
            
            return .uploadCompositeMultipart(
                [formData],
                urlParameters: ["word": word]
            )
            
        case .wordsGenerate(let missionCategory):
            let parameters: [String: Any] = ["category": missionCategory.rawValue]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        
            // TODO: existingWords 추가
        case .wordsRegenerate(let missionCategory):
            let parameters: [String: Any] = ["category": missionCategory.rawValue]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
