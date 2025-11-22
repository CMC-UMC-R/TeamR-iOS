//
//  ShakeMissionView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

/// 흔들기 미션 뷰
struct ShakeMissionView: View {
    
    // MARK: - Properties
    
    /// 흔들기 미션 ViewModel
    @StateObject private var viewModel: CoreMotionViewModel
    
    /// 목표 흔들기 횟수
    private let targetShakeCount: Int
    
    /// 완료 알림 표시 여부
    @State private var showCompletionAlert: Bool = false
    
    // MARK: - Initializer
    
    /// ShakeMissionView 초기화
    /// - Parameter targetShakeCount: 목표 흔들기 횟수 (기본값: 30)
    init(targetShakeCount: Int = 30) {
        self.targetShakeCount = targetShakeCount
        _viewModel = StateObject(wrappedValue: CoreMotionViewModel(targetCount: targetShakeCount))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 40) {
            // 타이틀
            Text("흔들기 미션")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 카운트 표시
            VStack(spacing: 16) {
                Text("현재 횟수")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("\(viewModel.shakeCount)")
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(viewModel.isMissionCompleted ? .green : .primary)
                
                Text("/ \(targetShakeCount)회")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            // 진행 상태 바
            ProgressView(value: progressValue)
                .progressViewStyle(.linear)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .padding(.horizontal, 40)
            
            // 완료 상태 표시
            if viewModel.isMissionCompleted {
                Text("🎉 미션 완료!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            // 컨트롤 버튼들
            VStack(spacing: 16) {
                if !viewModel.isDetecting {
                    Button(action: startMission) {
                        Text("미션 시작")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                } else {
                    Button(action: stopMission) {
                        Text("미션 중지")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                
                Button(action: resetMission) {
                    Text("초기화")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 40)
        }
        .padding()
        .alert("미션 완료!", isPresented: $showCompletionAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text("\(targetShakeCount)회 흔들기 미션을 완료했습니다!")
        }
    }
    
    // MARK: - Computed Properties
    
    /// 진행률 계산 (0.0 ~ 1.0)
    private var progressValue: Double {
        min(Double(viewModel.shakeCount) / Double(targetShakeCount), 1.0)
    }
    
    // MARK: - Methods
    
    /// 미션 시작
    private func startMission() {
        viewModel.startMission {
            // 목표 달성 시 실행될 콜백
            handleMissionComplete()
        }
    }
    
    /// 미션 중지
    private func stopMission() {
        viewModel.stopMission()
    }
    
    /// 미션 초기화
    private func resetMission() {
        viewModel.resetCount()
        showCompletionAlert = false
    }
    
    /// 미션 완료 처리
    private func handleMissionComplete() {
        showCompletionAlert = true
        
        // 햅틱 피드백
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        print("✅ 미션 완료 처리됨")
    }
}

// MARK: - Preview

#Preview {
    ShakeMissionView(targetShakeCount: 30)
}
