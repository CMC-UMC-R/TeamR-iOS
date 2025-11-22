//
//  MissionResultType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

enum MissionResultType: String {
    case none = ""
    case currentStart = "토끼0"
    case current = "토끼"   // 토끼
    case success = "성공"
    case failure = "실패"
    
    var iconImage: Image {
        switch self {
        case .none:
            Image("")
            
        case .currentStart:
            Image(.rabbit0)
            
        case .current:
            Image(.rabbit1)
            
        case .success:
            Image(.success)
            
        case .failure:
            Image(.failure)
        }
    }
}
