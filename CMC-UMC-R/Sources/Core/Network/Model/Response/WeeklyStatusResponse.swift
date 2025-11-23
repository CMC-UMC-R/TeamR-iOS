//
//  WeeklyStatusResponse.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

struct RootWeeklyStatusResponse: Codable {
    let dailyStatuses: [WeeklyStatusResponseElement]
}

struct WeeklyStatusResponseElement: Codable, Hashable {
    let dayOfWeek: DayOfWeek
    let date: String
    let isCompleted: Bool?
}

typealias WeeklyStatusResponse = [WeeklyStatusResponseElement]

extension WeeklyStatusResponse {
    static let stub01: WeeklyStatusResponse = [
        .init(dayOfWeek: .sunday, date: "2025-11-17", isCompleted: true),
        .init(dayOfWeek: .monday, date: "2025-11-18", isCompleted: true),
        .init(dayOfWeek: .tuesday, date: "2025-11-19", isCompleted: true),
        .init(dayOfWeek: .wednesday, date: "2025-11-20", isCompleted: false),
        .init(dayOfWeek: .thursday, date: "2025-11-21", isCompleted: true),
        .init(dayOfWeek: .friday, date: "2025-11-22", isCompleted: true),
        .init(dayOfWeek: .saturday, date: "2025-11-23", isCompleted: false),
    ]
}
