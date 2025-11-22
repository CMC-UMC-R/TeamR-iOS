//
//  MissionTarget.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya
import Alamofire

enum MissionTarget {
    case createMissions(CreateMissionRequest)   /// 미션 생성
    case getMissions(DayOfWeek)                 /// 요일별 미션 조회
    case getDailyMission(DayOfWeek)             /// 요일별 미션 목록 조회 (3개 고정)
    case getWeeklyStatus                        /// 이번 주 미션 달성 현황 조회
}

extension MissionTarget: BaseTargetType {
    var path: String {
        switch self {
        case .createMissions:
            MissionAPI.createMissions.path
        case .getMissions(let dayOfWeek):
            MissionAPI.getMissions(dayOfWeek).path
        case .getDailyMission(let dayOfWeek):
            MissionAPI.getDailyMission(dayOfWeek).path
        case .getWeeklyStatus:
            MissionAPI.getWeeklyStatus.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createMissions:
                .post
        case .getMissions:
                .get
        case .getDailyMission(_):
                .get
        case .getWeeklyStatus:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createMissions(let body):
            return .requestJSONEncodable(body)
            
        case .getMissions(let dayOfWeek):
            let parameters: [String: Any] = ["dayOfWeek": dayOfWeek.rawValue]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .getDailyMission(let dayOfWeek):
            let parameters: [String: Any] = ["dayOfWeek": dayOfWeek.rawValue]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .getWeeklyStatus:
            return .requestPlain
        }
    }
}
