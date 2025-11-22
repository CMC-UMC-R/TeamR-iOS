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
    let missionCategory, missionStatus: String
}
