//
//  MainViewModel.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI
import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published var missionLogResponse: MissionLogListResponse?
    @Published var weeklyStatusResponse: WeeklyStatusResponse?
    @Published var currentMission: Mission?
    @Published var dailyMissionResponse: DailyMissionResponse?
    
    @Published var mission: Mission = Mission(category: .wakeup, categoryTitle: "", missionType: .shoot, time: "10:00", word: "bed", count: 0)
    
    var missionLogService = MissionLogService()
    var missionService = MissionService()
    
}

extension MainViewModel {
    func getMissionLogList() async {
        do {
            missionLogResponse = try await missionLogService.getMissionLogsToday()
        } catch {
            print("getMissionLogList() error")
        }
    }
    
    func getWeeklyStatus() async {
        do {
            weeklyStatusResponse = try await missionService.getWeeklyStatus().dailyStatuses
        } catch {
            print("getWeeklyStatus() error")
        }
    }
    
    func getDailyMission() async {
        do {
            let missions = try await missionService.getDailyMission(dayOfWeek: .sunday).missions
            mission = MissionTimeHelper.getNextUpcomingMission(from: missions) ?? Mission(category: .move, categoryTitle: "", missionType: .move, time: "", word: "", count: 0)
        } catch {
            print("getDailyMission() error")
        }
    }
}
