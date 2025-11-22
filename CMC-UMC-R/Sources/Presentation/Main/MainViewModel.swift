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
    
    var missionLogService = MissionLogService()
    
}

extension MainViewModel {
    func getMissionLogList() async {
        do {
            missionLogResponse = try await missionLogService.getMissionLogsToday()
        } catch {
            print("getMissionLogList() error")
        }
    }
}
