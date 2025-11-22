//
//  MissionLogAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum MissionLogAPI {
    case missionLogsToday           /// 오늘의 미션 성공 여부 반환
    case missionLogsTodayComplete   /// 미션 성공 표시
    
    var path: String {
        switch self {
        case .missionLogsToday:
            "mission-logs/today"
        case .missionLogsTodayComplete:
            "mission-logs/today/complete"
        }
    }
}
