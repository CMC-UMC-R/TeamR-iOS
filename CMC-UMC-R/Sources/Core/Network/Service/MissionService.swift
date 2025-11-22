//
//  MissionService.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/23/25.
//

import Foundation
import Moya

struct MissionsResponse: Codable {
    let dayOfWeek: String
    let missions: [Mission]
}

struct CreateMissionResponse: Codable {
    let missionId: Int
    let missionType: MissionType
    let word: String
    let count: Int
}

struct CreateMissionRequest: Codable {
    let userId: String
    let time: String
    let missionCategory: MissionCategoryType
    let geminiCategory: GeminiCategory?
    let missionType: MissionType
    let dayOfWeek: DayOfWeek
    let word: String?
    let count: Int?
}

class MissionService {
    private let jsonDecoder = JSONDecoder()
    let provider = MoyaProvider<MissionTarget>(plugins: [MoyaLoggingPlugin()])
}

extension MissionService {
    func getMissions(dayOfWeek: DayOfWeek) async throws -> MissionsResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getMissions(dayOfWeek)) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(MissionsResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("getMissions() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func createMissions(createMissionRequest: CreateMissionRequest) async throws -> CreateMissionResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.createMissions(createMissionRequest)) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(CreateMissionResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("getMissions() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func getDailyMission(dayOfWeek: DayOfWeek) async throws -> DailyMissionResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getDailyMission(dayOfWeek)) { result in
                switch result {
                case let .success(response):
                    do {
                        let response = try self.jsonDecoder.decode(DailyMissionResponse.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        Log.network("getMissions() 실패", error.localizedDescription)
                        continuation.resume(throwing: error)
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
//    func getWeeklyStatus() async throws -> {
//        return try await withCheckedThrowingContinuation { continuation in
//            provider.request(.getWeeklyStatus) { result in
//                switch result {
//                case let .success(response):
//                    do {
//                        let response = try self.jsonDecoder.decode(CreateMissionResponse.self, from: response.data)
//                        continuation.resume(returning: response)
//                    } catch {
//                        Log.network("getMissions() 실패", error.localizedDescription)
//                        continuation.resume(throwing: error)
//                    }
//                    
//                case let .failure(error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
}
