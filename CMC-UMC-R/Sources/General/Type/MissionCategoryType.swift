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
