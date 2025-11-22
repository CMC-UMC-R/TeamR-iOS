//
//  MissionAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum MissionAPI {
    case createMissions                             /// 미션 생성
    case getMissions(DayOfWeekType)       /// 요일별 미션 조회
    
    var path: String {
        switch self {
        case .createMissions:
            "missions"
        case .getMissions(let dayOfWeekType):
            "missions/\(dayOfWeekType.rawValue)"
        }
    }
}
