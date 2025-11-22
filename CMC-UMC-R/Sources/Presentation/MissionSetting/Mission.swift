//
//  Mission.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

enum MissionCategory: String, Codable {
    case start = "START"
    case wakeup = "WAKE_UP"
    case move = "MOVEMENT"
    case work = "WORK"

    var displayName: String {
        switch self {
        case .start: return "시작"
        case .wakeup: return "기상"
        case .move: return "이동"
        case .work: return "작업"
        }
    }
}

extension MissionCategory {
    var geminiCategories: [GeminiCategory] {
        switch self {
        case .wakeup:
            return [
                .bedroom,
                .livingRoom,
                .bathroom,
                .kitchen,
                .dressingRoom
            ]

        case .move:
            return [
                .martConvenience,
                .building,
                .streetTree,
                .road
            ]

        case .work:
            return [
                .studyRoom,
                .beverage,
                .computer,
                .writingTools,
                .bookNote
            ]

        default:
            return []
        }
    }
}


enum MissionType: String, CaseIterable, Codable {
    case move = "MOVEMENT"
    case shoot = "PICTURE"
    
    var displayName: String {
        switch self {
        case .move: return "활동 인증"
        case .shoot: return "사진 인증"
        }
    }
}


struct Mission: Codable, Hashable {
    let missionCategory: MissionCategory
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
