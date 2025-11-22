//
//  MissionSettingView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI

struct MissionSettingView: View {
    let days = ["일", "월", "화", "수", "목", "금", "토"]
    @State var isSheetPresent = false
//    @State var missionType: MissionType = .wakeup
    @State var mission: Mission = Mission(
        type: .wakeup,
        category: .move,
        detail: "00회",
        completeTime: DateComponents(
            calendar: .current,
            year: 2025, month: 1, day: 15,
            hour: 7, minute: 0
        ).date!
    )
    
    @State var date: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(days.enumerated()), id: \.offset) { index, day in
                    Button {
                        date = currentWeekDates()[index]
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    currentWeekDates()[index].isSameDay(as: date)
                                    ? Color.blue.opacity(0.2)
                                    : Color.clear
                                )
                                .frame(width: 37, height: 37)

                            Text(day)
                                .foregroundStyle(.black)
                                .padding()
                        }
                    }
                }
            }
            .padding()
            
            Divider()
            
            VStack {
                ForEach(Mission.missions, id: \.self) { mission in
                    componentView(type: mission.type.rawValue, completeTime: mission.completeTime)
                        .onTapGesture {
                            self.mission = mission
                            isSheetPresent = true
                        }
                }
            }
            .padding()
            
            Spacer()
        }
        .sheet(isPresented: $isSheetPresent) {
            MissionCreateView(mission: $mission, date: $date)
                .presentationDragIndicator(.visible)
        }
    }
    
    func componentView(type: String, completeTime: Date) -> some View {
        VStack {
            HStack {
                Text("\(type)")
                Spacer()
            }
            HStack {
                Image(systemName: "")
                Spacer()
                Text("\(completeTime.timeString)")
                Image(systemName: "chevron.right")
            }
        }
        .padding()
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    func currentWeekDates() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        
        // 이번 주의 "일요일" 구하기
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        // 일~토 7개 날짜 생성
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: weekStart)
        }
    }
}
