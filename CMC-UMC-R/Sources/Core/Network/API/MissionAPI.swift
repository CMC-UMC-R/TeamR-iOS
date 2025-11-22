//
//  MissionAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum MissionAPI {
    case createMissions             /// 미션 생성
    case getMissions(DayOfWeek)     /// 요일별 미션 조회
    case getDailyMission(DayOfWeek) /// 요일별 미션 목록 조회 (3개 고정)
    case getWeeklyStatus            /// 이번 주 미션 달성 현황 조회
    
    var path: String {
        switch self {
        case .createMissions:
            "missions"
        case .getMissions(let dayOfWeek):
            "missions/\(dayOfWeek.rawValue)"
        case .getDailyMission(let dayOfWeek):
            "missions/daily/\(dayOfWeek.rawValue)"
        case .getWeeklyStatus:
            "missions/weekly-status"
        }
    }
}
