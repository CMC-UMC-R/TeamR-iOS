//
//  MissionType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum MissionType: String, CaseIterable, Codable {
    case move = "MOVEMENT"
    case shoot = "PICTURE"
    
    var displayName: String {
        switch self {
        case .move: return "활동 인증"
        case .shoot: return "사진 인증"
        }
    }
}
