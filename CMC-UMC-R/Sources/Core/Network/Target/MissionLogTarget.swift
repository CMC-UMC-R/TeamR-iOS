//
//  MissionLogTarget.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya
import Alamofire

enum MissionLogTarget {
    case missionLogsToday           /// 오늘의 미션 성공 여부 반환
    case missionLogsTodayComplete   /// 미션 성공 표시
}

extension MissionLogTarget: BaseTargetType {
    var path: String {
        switch self {
        case .missionLogsToday:
            "/api/mission-logs/today"
        case .missionLogsTodayComplete:
            "/api/mission-logs/today/complete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .missionLogsToday:
                .get
        case .missionLogsTodayComplete:
                .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .missionLogsToday:
                .requestPlain
        case .missionLogsTodayComplete:
                .requestPlain
        }
    }
}
