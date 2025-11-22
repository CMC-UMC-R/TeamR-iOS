//
//  MissionSettingView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI

enum DayOfWeek: String, Codable, CaseIterable {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"

    /// 화면 표시용 한글 변환
    var displayName: String {
        switch self {
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        case .sunday: return "일"
        }
    }
    
    var index: Int {
        switch self {
        case .monday: return 0
        case .tuesday: return 1
        case .wednesday: return 2
        case .thursday: return 3
        case .friday: return 4
        case .saturday: return 5
        case .sunday: return 6
        }
    }
}


struct MissionSettingView: View {
    @StateObject var viewModel = MissionSettingViewModel()
    let baseMissionTypes: [MissionCategoryType] = [.wakeup, .move, .work]
    @State var isSheetPresent = false
    
    @State var date: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(DayOfWeek.allCases, id: \.self) { day in
                    Button {
                        viewModel.selectedDayOfWeek = day
                        Task { await viewModel.fetchMissions() }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    viewModel.selectedDayOfWeek == day
                                    ? Color.primary700
                                    : Color.primary500
                                )
                                .frame(width: 37, height: 37)

                            Text(day.displayName)
                                .fontStyle(.main3)
                                .foregroundStyle(.black)
                                .padding()
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                ForEach(baseMissionTypes, id: \.self) { type in
                    let existingMission = viewModel.missions.first(where: { $0.category == type })
                    
                    componentView(
                        type: type.displayName,
                        completeTime: existingMission?.time,
                    )
                    .onTapGesture {
                        if existingMission?.missionType == nil {
                            viewModel.selectedCategory = type
                            isSheetPresent = true
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .sheet(isPresented: $isSheetPresent) {
            MissionCreateView(viewModel: viewModel, date: $date)
                .presentationDragIndicator(.visible)
                .onAppear {
                    viewModel.reset()
                }
                .onDisappear {
                    Task { await viewModel.fetchMissions() }
                }
        }
        .task {
            await viewModel.fetchMissions()
            print(viewModel.missions)
        }
    }
    
    func componentView(type: String, completeTime: String?) -> some View {
        VStack {
            HStack {
                Text("\(type)")
                    .fontStyle(.title)
                    .foregroundStyle(Color.primary900)
                Spacer()
            }
            HStack {
                Text("\(completeTime ?? "00:00")")
                    .fontStyle(.display1)
                    .foregroundStyle(Color.gray600)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gray200)
                Spacer()
            }
        }
        .padding()
        .background(Color.primary400)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.10), radius: 12, x: 0, y: 0)
        .shadow(color: Color.gray400.opacity(0.06), radius: 10, x: 0, y: 0)
        .padding(.bottom)
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
