//
//  MissionCategoryType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum GeminiCategoryType: String, Codable, CaseIterable {

    // MARK: - 기상 미션
    case bedroom = "BEDROOM"                 // 침실
    case livingRoom = "LIVING_ROOM"          // 거실
    case bathroom = "BATHROOM"               // 화장실
    case kitchen = "KITCHEN"                 // 주방
    case dressingRoom = "DRESSING_ROOM"      // 옷방

    // MARK: - 이동 미션
    case martConvenience = "MART_CONVENIENCE" // 마트/편의점
    case building = "BUILDING"               // 건물
    case streetTree = "STREET_TREE"          // 가로수
    case road = "ROAD"                       // 도로

    // MARK: - 작업 미션
    case studyRoom = "STUDY_ROOM"            // 서재
    case beverage = "BEVERAGE"               // 커피/음료
    case computer = "COMPUTER"               // 노트북/데스크탑
    case writingTools = "WRITING_TOOLS"      // 필기도구
    case bookNote = "BOOK_NOTE"              // 책/노트

    // MARK: - 한글 표시
    var displayName: String {
        switch self {

        // 기상
        case .bedroom: return "침실"
        case .livingRoom: return "거실"
        case .bathroom: return "화장실"
        case .kitchen: return "주방"
        case .dressingRoom: return "옷방"

        // 이동
        case .martConvenience: return "마트/편의점"
        case .building: return "건물"
        case .streetTree: return "가로수"
        case .road: return "도로"

        // 작업
        case .studyRoom: return "서재"
        case .beverage: return "커피/음료"
        case .computer: return "노트북/데스크탑"
        case .writingTools: return "필기도구"
        case .bookNote: return "책/노트"
        }
    }
}
