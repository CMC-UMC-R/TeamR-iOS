//
//  Mission.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

struct Mission: Codable, Hashable {
    let missionCategory: MissionCategoryType
    let missionType: MissionType
    let detail: String
    let completeTime: Date
    
    static let missions: [Mission] = [
        Mission(
            missionCategory: .wakeup,
            missionType: .move,
            detail: "00회",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 11, day: 23,
                hour: 7, minute: 0
            ).date!
        ),
        
        Mission(
            missionCategory: .move,
            missionType: .shoot,
            detail: "00보",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 11, day: 23,
                hour: 12, minute: 30
            ).date!
        ),
        
        Mission(
            missionCategory: .work,
            missionType: .move,
            detail: "000",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 11, day: 23 ,
                hour: 21, minute: 45
            ).date!
        )
    ]

}
