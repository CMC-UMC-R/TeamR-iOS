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
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let leftTime: Date
    
    
    var body: some View {
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
                Text("\(mission.missionType?.displayName ?? "") 미션")
                    .fontStyle(.display2)
                    .foregroundStyle(Color.black)
                
                VStack {
                    HStack {
                        let missionText =
                            mission.word != nil
                            ? "\(mission.word!) 촬영하기"
                            : "\(mission.count ?? 0) 움직이기"

                        
                        Text("\(missionText)")
                            .fontStyle(.main1)
                            .foregroundStyle(Color.primary900)
                        
                        Image("icon - restart")
                    }
                    
                    Image(mission.missionType == .move ? "illust-active" : "illust-camera")
                }
                .padding(.bottom, 48)
                
                Button {
                    
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
        }
        .padding()
        .onReceive(timer) { current in
            now = current
        }
        .task {
//            print(await DistanceTrackingManager.shared.evaluateMissionHistory(endDate: mission.completeTime, targetSteps: 1000))
        }
    }
    
    var remainingTimeText: String {
        let target = leftTime.addingTimeInterval(10 * 60)
        let remaining = max(0, target.timeIntervalSince(now))
        
        let minutes = Int(remaining) / 60
        let seconds = Int(remaining) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
