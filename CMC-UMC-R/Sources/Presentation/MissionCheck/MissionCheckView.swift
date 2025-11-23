//
//  MissionCheckView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI
import Combine
import UIKit

struct MissionCheckView: View {
    @State private var now: Date = Date()
    @Binding var mission: Mission
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let leftTime: Date
    @State var showSuccess = false
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    private let geminiService = GeminiAIService()
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        Image("icon-timer")
                        
                        Text("남은 시간")
                            .fontStyle(.main1)
                            .foregroundStyle(.red)
                    }
                    
                    Text(remainingTimeText)
                        .fontStyle(.display1)
                        .foregroundStyle(.red)
                        .monospacedDigit()
                }
                
                VStack {
                    Text("\(mission.category.displayName) 미션")
                        .fontStyle(.display2)
                        .foregroundStyle(Color.black)
                    
                    VStack {
                        HStack {
                            Text(mission.missionType == .move ? "\(mission.count ?? 0) 움직이기" : "\(mission.word!) 촬영하기")
                                .fontStyle(.main1)
                                .foregroundStyle(Color.primary900)
                            
                            Image("icon - restart")
                        }
                        
                        Image(mission.missionType == .move ? "illust-active" : "illust-camera")
                    }
                    .padding(.bottom, 48)
                }
                .padding()
                .background(Color.primary400)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 0)
                .padding()
                
                Button {
                    if mission.category == .move && mission.missionType == .move {
                        Task {
                            let result = await DistanceTrackingManager.shared.evaluateMissionHistory(endDate: todayAt(time: mission.time) ?? Date(), targetSteps: mission.count ?? 0)

                            if result {
                                showSuccess = true
                            }
                        }
                    } else if mission.category == .wakeup && mission.missionType == .move {
                        Task {
                            let viewModel = CoreMotionViewModel(targetCount: mission.count ?? 0)
                            
                            viewModel.startMission{}
                            let result = await viewModel.waitUntilCompleted()
                            
                            if result {
                                showSuccess = true
                            }
                        }
                    } else {
                        // 카메라 인증
                        showCamera = true
                    }
                } label: {
                    Text("미션 인증")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.primary100)
                        .background(Color.primary800)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(isLoading)
                .padding(.horizontal)
            }
            
            // Loading Indicator
            if isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .tint(.white)
                    
                    Text("인증 중...")
                        .fontStyle(.main1)
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color.primary700)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Success View
            if showSuccess {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismiss()
                    }
                
                VStack {
                    Text("인증 완료 !")
                        .fontStyle(.display2)
                        .foregroundStyle(.white)
                    
                    Image("rabbit1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 397)
                .background(Color.primary700)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
            }
        }
        .onReceive(timer) { current in
            now = current
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(
                selectedImage: $selectedImage,
                isPresented: $showCamera,
                sourceType: .camera
            )
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                Task {
                    await verifyWithCamera(image: image)
                    selectedImage = nil // 이미지 초기화
                }
            }
        }
        .alert("인증 실패", isPresented: $showError, actions: {
            Button("확인", role: .cancel) { }
        }, message: {
            Text(errorMessage)
        })
    }
    
    var remainingTimeText: String {
        let target = leftTime.addingTimeInterval(10 * 60)
        let remaining = max(0, target.timeIntervalSince(now))
        
        let minutes = Int(remaining) / 60
        let seconds = Int(remaining) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func todayAt(time: String) -> Date? {
        let parts = time.split(separator: ":")
        guard parts.count == 2,
              let hour = Int(parts[0]),
              let minute = Int(parts[1]) else { return nil }

        return Calendar.current.date(
            bySettingHour: hour,
            minute: minute,
            second: 0,
            of: Date()
        )
    }
    
    // MARK: - Camera Verification
    private func verifyWithCamera(image: UIImage) async {
        guard let word = mission.word else {
            errorMessage = "미션 단어가 없습니다."
            showError = true
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            errorMessage = "이미지 처리 실패"
            showError = true
            return
        }
        
        isLoading = true
        
        do {
            let response = try await geminiService.verifyMission(
                word: word,
                imageData: imageData
            )
            
            isLoading = false
            
            if response.status == "APPROVED" {
                showSuccess = true
                // 미션 완료 처리
//                mission.isCompleted = true
            } else {
                errorMessage = response.reason
                showError = true
            }
        } catch {
            isLoading = false
            errorMessage = "네트워크 오류: \(error.localizedDescription)"
            showError = true
        }
    }
}
