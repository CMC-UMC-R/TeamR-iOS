//
//  MissionCategoryType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//


enum MissionCategoryType: String, Codable {
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

extension MissionCategoryType {
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
