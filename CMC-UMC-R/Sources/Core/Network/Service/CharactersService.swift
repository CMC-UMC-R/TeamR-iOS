//
//  CharactersService.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya

class CharactersService {
    private let jsonDecoder = JSONDecoder()
    let provider = MoyaProvider<CharactersTarget>(plugins: [MoyaLoggingPlugin()])
}

extension CharactersService {
    func getMyCharacter() async throws -> CharactersResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getMe) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(CharactersResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("getMyCharacter() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
