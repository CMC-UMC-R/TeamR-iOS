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
    @Published var selectedType: MissionType = .shoot
    @Published var selectedGeminiCategory: GeminiCategoryType?
    @Published var selectedDayOfWeek: DayOfWeek = .sunday
    @Published var count = ""
    @Published var hour = 0
    @Published var minute = 0
    @Published var word = ""
    
    private let service = MissionService()
    private let geminiAIService = GeminiAIService()
    
    func reset() {
        selectedType = .shoot
        selectedGeminiCategory = nil
        count = ""
        hour = 0
        minute = 0
    }

    func saveMission() async {
        var createMissionRequest: CreateMissionRequest
        
        if selectedType == .move {
            createMissionRequest = CreateMissionRequest(userId: DeviceManager.getDeviceUUID(), time: String(format: "%02d:%02d", hour, minute), missionCategory: selectedCategory, geminiCategory: selectedGeminiCategory, missionType: selectedType, dayOfWeek: selectedDayOfWeek, word: nil, count: Int(count))
        } else {
            await fetchGeneratedWord()
            createMissionRequest = CreateMissionRequest(userId: DeviceManager.getDeviceUUID(), time: String(format: "%02d:%02d", hour, minute), missionCategory: selectedCategory, geminiCategory: selectedGeminiCategory, missionType: selectedType, dayOfWeek: selectedDayOfWeek, word: word, count: nil)
        }
        
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
        guard let category = selectedGeminiCategory else { return }
        
        do {
            let response = try await geminiAIService.generateWord(geminiCategoryType: category)
            self.word = response.word
        } catch {
            Log.network("미션 단어 생성 실패: \(error.localizedDescription)")
        }
    }
}
