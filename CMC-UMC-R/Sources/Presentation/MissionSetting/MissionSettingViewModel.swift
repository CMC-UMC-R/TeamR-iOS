//
//  MissionSettingViewModel.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation
import Combine

@MainActor
final class MissionSettingViewModel: ObservableObject {
    @Published var missions: [Mission] = []
    
    @Published var selectedCategory: MissionCategoryType = .move
    @Published var selectedType: MissionType = .move
    @Published var selectedGeminiCategory: GeminiCategory?
    @Published var selectedDayOfWeek: DayOfWeek = .sunday
    @Published var count = ""
    @Published var hour = 0
    @Published var minute = 0
    
    private let service = MissionService()
    
    func reset() {
        selectedType = .move
        selectedGeminiCategory = nil
        count = ""
        hour = 0
        minute = 0
    }

    func saveMission() async {
        let createMissionRequest = CreateMissionRequest(userId: DeviceManager.getDeviceUUID(), time: String(format: "%02d:%02d", hour, minute), missionCategory: selectedCategory, geminiCategory: selectedGeminiCategory, missionType: selectedType, dayOfWeek: selectedDayOfWeek, word: "", count: Int(0))
        
        do {
            let response = try await service.createMissions(createMissionRequest: createMissionRequest)
            Log.network(response)
        } catch {
            Log.network("미션 저장 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchMissions() async {
        do {
            let response = try await service.getMissions(dayOfWeek: selectedDayOfWeek)
            self.missions = response.missions
        } catch {
            Log.network("미션 불러오기 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchGeneratedWord() async {
        
    }
}
