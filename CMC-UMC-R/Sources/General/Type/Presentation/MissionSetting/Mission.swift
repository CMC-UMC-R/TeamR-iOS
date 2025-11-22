//
//  Mission.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

struct Mission: Codable, Hashable {
    let category: MissionCategoryType
    let categoryTitle: String
    let missionType: MissionType?
    let time: String
    let word: String?
    let count: Int?
}
