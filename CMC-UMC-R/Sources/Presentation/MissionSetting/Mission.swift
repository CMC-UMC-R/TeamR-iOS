//
//  Mission.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

enum MissionType: String, Codable {
    case start = "START"
    case wakeup = "기상"
    case move = "이동"
    case work = "작업"
}

enum Category: String, CaseIterable, Codable {
    case move = "활동 인증"
    case shoot = "사진 인증"
}


struct Mission: Codable, Hashable {
    let type: MissionType
    let category: Category
    let detail: String
    let completeTime: Date
    
    static let missions: [Mission] = [
        Mission(
            type: .wakeup,
            category: .move,
            detail: "00회",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 1, day: 15,
                hour: 7, minute: 0
            ).date!
        ),
        
        Mission(
            type: .move,
            category: .shoot,
            detail: "00보",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 1, day: 15,
                hour: 12, minute: 30
            ).date!
        ),
        
        Mission(
            type: .work,
            category: .move,
            detail: "000",
            completeTime: DateComponents(
                calendar: .current,
                year: 2025, month: 1, day: 15,
                hour: 21, minute: 45
            ).date!
        )
    ]

}
