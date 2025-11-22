//
//  MissionLogService.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya

class MissionLogService {
    private let jsonDecoder = JSONDecoder()
    let provider = MoyaProvider<MissionLogTarget>(plugins: [MoyaLoggingPlugin()])
}

extension MissionLogService {
    func getMissionLogsToday() async throws -> MissionLogListResponse { /// 오늘의 미션 성공 여부 반환
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.missionLogsToday) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(MissionLogListResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("MissionLogService - getMissionLogsToday() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getMissionLogsTodayComplete() async throws -> MissionLogResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.missionLogsTodayComplete) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(MissionLogResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("MissionLogService - getMissionLogsTodayComplete() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
