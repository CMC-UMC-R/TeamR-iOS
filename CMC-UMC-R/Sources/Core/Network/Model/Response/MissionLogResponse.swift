//
//  MissionLogResponse.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

struct MissionLogListResponse: Codable {
    let logList: [MissionLogResponse]
}

struct MissionLogResponse: Codable {
    let missionCategory: MissionCategoryType
    let missionStatus: MissionStatusType
}

extension MissionLogResponse {
    static let stub01: MissionLogResponse = .init(missionCategory: .wakeup, missionStatus: .SUCCESS)
    static let stub02: MissionLogResponse = .init(missionCategory: .move, missionStatus: .FAILURE)
    static let stub03: MissionLogResponse = .init(missionCategory: .work, missionStatus: .PENDING)
}

extension MissionLogListResponse {
    static let stub01: MissionLogListResponse = .init(logList: [.stub01, .stub02, .stub03])
}
