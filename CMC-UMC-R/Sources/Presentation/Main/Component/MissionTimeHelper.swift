//
//  MissionTimeHelper.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//


//
//  MissionTimeHelper.swift
//  CMC-UMC-R
//
//  Created by Assistant on 11/23/25.
//

import Foundation

struct MissionTimeHelper {
    
    /// 현재 시각을 기준으로 아직 지나지 않은 가장 가까운 미션을 반환
    /// - Parameter missions: 미션 배열
    /// - Returns: 가장 가까운 미션 (없으면 nil)
    static func getNextUpcomingMission(from missions: [Mission]) -> Mission? {
        let now = Date()
        let calendar = Calendar.current
        
        // 현재 시각 이후의 미션들만 필터링하고 시간순 정렬
        let upcomingMissions = missions
            .compactMap { mission -> (mission: Mission, date: Date)? in
                guard let missionDate = parseTimeToDate(mission.time, calendar: calendar) else {
                    return nil
                }
                
                // 현재 시각 이후인 미션만 포함
                guard missionDate > now else {
                    return nil
                }
                
                return (mission, missionDate)
            }
            .sorted { $0.date < $1.date } // 시간순 정렬
        
        // 가장 가까운 미션 (첫 번째) 반환
        return upcomingMissions.first?.mission
    }
    
    /// "HH:mm" 형식의 시간 문자열을 오늘 날짜의 Date로 변환
    /// - Parameters:
    ///   - timeString: "09:40" 형식의 시간 문자열
    ///   - calendar: 사용할 캘린더 (기본값: Calendar.current)
    /// - Returns: 변환된 Date 객체 (실패시 nil)
    private static func parseTimeToDate(_ timeString: String, calendar: Calendar) -> Date? {
        let components = timeString.split(separator: ":").compactMap { Int($0) }
        
        guard components.count == 2 else {
            return nil
        }
        
        let hour = components[0]
        let minute = components[1]
        
        // 오늘 날짜에 시간 설정
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        
        return calendar.date(from: dateComponents)
    }
}
