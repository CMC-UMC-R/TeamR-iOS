//
//  MissionCheckView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI
import Combine

struct MissionCheckView: View {
    @State private var now: Date = Date()
    @Binding var mission: Mission
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let leftTime: Date
    @State var showSuccess = false
    
    @Environment(\.dismiss) var dismiss
    
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
                                
                                viewModel.startMission {}
                                let result = await viewModel.waitUntilCompleted()
                                
                                if result {
                                    showSuccess = true
                                }
                            }
                        } else {
                            // 카메라 인증
                        }
                    } label: {
                        Text("미션 인증")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primary100)
                            .background(Color.primary800)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
                .background(Color.primary400)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 0)
                .padding()
            }
            .onReceive(timer) { current in
                now = current
            }
            
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

}
