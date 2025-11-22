//
//  MissionStatusType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

enum MissionStatusType: Codable {
    case START
    case SUCCESS    /// 미션 실패
    case PENDING    /// 미션 대기
    case FAILURE    /// 미션 실팬
    
    var iconImage: Image {
        switch self {
        case .START:
            Image(.rabbit0)
        case .SUCCESS:
            Image(.success)
        case .PENDING:
            Image(.rabbit1)
        case .FAILURE:
            Image(.failure)
        }
    }
}
