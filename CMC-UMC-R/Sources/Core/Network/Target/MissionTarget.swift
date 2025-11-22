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
    case createMissions(CreateMissionRequest)                             /// 미션 생성
    case getMissions(DayOfWeek)       /// 요일별 미션 조회
}

extension MissionTarget: BaseTargetType {
    var path: String {
        switch self {
        case .createMissions:
            MissionAPI.createMissions.path
        case .getMissions(let dayOfWeekType):
            MissionAPI.getMissions(dayOfWeekType).path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createMissions:
                .post
        case .getMissions:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createMissions(let body):
            return .requestJSONEncodable(body)
        case .getMissions:
            return .requestPlain
            
//            let parameters: [String: Any] = ["dayOfWeekType": dayOfWeekType.rawValue]
//            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
