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
            weeklyStatusResponse = try await missionService.getWeeklyStatus()
        } catch {
            print("getWeeklyStatus() error")
        }
    }
}
