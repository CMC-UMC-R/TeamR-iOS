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
    case createMissions                             /// 미션 생성
    case getMissions(DayOfWeekType)       /// 요일별 미션 조회
}

extension MissionTarget {
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
                .get
        case .getMissions(let dayOfWeekType):
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createMissions:
            return .requestPlain
        case .getMissions(let dayOfWeekType):
            let parameters: [String: Any] = ["dayOfWeekType": dayOfWeekType.rawValue]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
