//
//  MainView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct MainView: View {
    
    @State var mainViewModel = MainViewModel()
    
    @State var mission = Mission(category: .wakeup, categoryTitle: "", missionType: .move, time: "09:00", word: nil, count: 1)
    
    var dailyChecklist: [Bool] = [true, true, true, false, false, false, false]
    
    let leftPadding: CGFloat = 52
    let rightPadding: CGFloat = 59
    let topMargin: CGFloat = 74
    
    let boardHeightRatio: CGFloat = 472 / 768
    let goalHeightRatio: CGFloat = 68 / 472
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    headerView()
                    dailyIconListView()
                    missionBoardView(geo.size.height * boardHeightRatio)
                    buttonListView()
                }
            }
            .onAppear {
                Task {
                    await mainViewModel.getMissionLogList()
                    await mainViewModel.getWeeklyStatus()
                }
            }
        }
    }
    
    func headerView() -> some View {
        HStack {
            Text("11월 21일")
                .fontStyle(.display1)
            Spacer()
            Text("구름")
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
    }
    
    // 날짜 아이콘 리스트
    func dailyIconListView() -> some View {
        HStack {
            ForEach(mainViewModel.weeklyStatusResponse ?? .stub01, id: \.self) { day in
                DailyCheckView(isChecked: day.isCompleted ?? true, date: day.date)
            }
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 12)
    }
    
    // 미션보드
    func missionBoardView(_ boardHeight: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            missionRoadView()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: boardHeight)
            
            goalView(boardHeight * goalHeightRatio)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 42)
    }
    
    // 미션 길
    func missionRoadView() -> some View {
        GeometryReader { geo in
            RoadPathShape(leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin)
                .stroke(Color.sub300, lineWidth: 15)
            
                .overlay {
                    RoadPathShape(leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin)
                        .stroke(
                            Color.sub800,
                            style: StrokeStyle(
                                lineWidth: 3,
                                lineCap: .round,
                                lineJoin: .round,
                                dash: [11, 11]
                            )
                        )
                }
                .overlay {
                    CirclesOverlay(width: geo.size.width, height: geo.size.height, leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin, response: mainViewModel.missionLogResponse ?? .stub01)
                    
                }
        }
    }
    
    func goalView(_ height: CGFloat) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text("GOAL")
                    .fontStyle(.main2)
                Image(.flag)
                Spacer()
            }
            .padding(.leading, 20)
            
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.sub300)
                .frame(height: height)
        }
    }
    
    func buttonListView() -> some View {
        HStack(spacing: 9) {
            NavigationLink {
                MissionSettingView()
            } label: {
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 105, height: 54)
                    .foregroundStyle(Color.primary500)
                    .overlay {
                        Text("미션 설정")
                            .fontStyle(.main1)
                            .foregroundStyle(.black)
                        
                    }
                
            }
            
            NavigationLink {
//                let mission = MissionTimeHelper.getNextUpcomingMission(from: mainViewModel.dailyMissionResponse?.missions as! [Mission])
//                
//                if let missionDate = todayDate(from: mission.time) {
//                    let testLeftTime = Calendar.current.date(byAdding: .minute, value: 0, to: missionDate)!
//                    MissionCheckView(mission: <#T##Binding<Mission>#>, leftTime: missionDate)
//                }
                MissionCheckView(mission: $mission, leftTime: Calendar.current.date(byAdding: .minute, value: 0, to: Date())!)
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundStyle(Color.primary800)
                    .overlay {
                        Text("미션 인증")
                            .foregroundStyle(.white)
                        
                    }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func todayDate(from timeString: String) -> Date? {
        // timeString: "HH:mm" 또는 "HH:mm:ss"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = .current
        
        // 서버가 "00:16" 또는 "00:16:00" 둘 다 가능하므로 이렇게 처리
        if timeString.count == 5 {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "HH:mm:ss"
        }
        
        guard let time = formatter.date(from: timeString) else { return nil }
        
        // 오늘 날짜 가져오기
        let today = Calendar.current.startOfDay(for: Date())
        
        // time에서 시/분/초 추출
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: time)
        
        // 오늘 날짜 + time 의 시간 합치기
        return Calendar.current.date(bySettingHour: components.hour ?? 0,
                                     minute: components.minute ?? 0,
                                     second: components.second ?? 0,
                                     of: today)
    }

}

#Preview {
    MainView()
}
