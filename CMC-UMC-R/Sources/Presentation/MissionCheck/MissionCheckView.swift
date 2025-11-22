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
            Text("남은 시간")
            Text(remainingTimeText)
                            .font(.system(size: 28, weight: .bold))
                            .monospacedDigit()
                            .foregroundStyle(.black)
            
            VStack {
                Text("\(mission.type.rawValue) 미션")
                HStack {
                    Text("\(mission.detail)")
                    Image("")
                }
                Image("")
                Button {
                    
                } label: {
                    Text("미션 인증")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
            .background(.gray.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 0)
        }
        .padding()
        .onReceive(timer) { current in
                    now = current
                }
    }
    
    var remainingTimeText: String {
        let target = leftTime.addingTimeInterval(5 * 60)
           let remaining = max(0, target.timeIntervalSince(now))
           
           let minutes = Int(remaining) / 60
           let seconds = Int(remaining) % 60
           
           return String(format: "%02d:%02d", minutes, seconds)
       }
}

//#Preview {
//    MissionCheckView()
//}
