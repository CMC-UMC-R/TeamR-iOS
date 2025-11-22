//
//  DailyMissionResonse.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

struct DailyMissionResponse: Codable {
    let dayOfWeek: DayOfWeek
    let missions: [DailyMission]
}

struct DailyMission: Codable {
    let category: MissionCategoryType
    let categoryTitle: String
    let missionType: MissionType
    let time: String
    let word: String
    let count: Int
}
