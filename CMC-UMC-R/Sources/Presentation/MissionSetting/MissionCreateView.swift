//
//  MissionCreateView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI

struct MissionCreateView: View {
    @Binding var mission: Mission
    @Binding var date: Date
    @State var selectedCategory: Category = .move
//    @State private var selectedDetail = "00회"
    @State private var count = ""
    @State private var hour = 0
    @State private var minute = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("\(mission.type.rawValue) 미션")
            
            categoryView()
            
            if selectedCategory == .move {
                movementView()
            }
            
            timeSettingView()
            
            Button {
                Task {
                    do {
                        let scheduledDate = Calendar.current.date(
                            bySettingHour: hour,
                            minute: minute,
                            second: 0,
                            of: date
                        )!
                        
                        let identifier = try await NotificationManager.shared.scheduleMissionNotification(
                            at: scheduledDate,
                            title: "1000보 미션 시작!",
                            body: scheduledDate.formatted(date: .abbreviated, time: .shortened) + "에 목표를 잊지 마세요."
                        )
                        
                        dismiss()
                        
                        print("알림 등록됨: \(identifier)")
                    } catch {
                        print("알림 등록 실패:", error.localizedDescription)
                    }
                }
            } label: {
                Text("저장")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.black)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    
    func categoryView() -> some View {
        VStack {
            HStack {
                ForEach(Category.allCases, id: \.self) { mode in
                    Text("\(mode.rawValue)")
                        .foregroundColor(selectedCategory == mode ? .black : .gray)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            selectedCategory == mode
                            ? Color.white
                            : Color.gray.opacity(0.2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            selectedCategory = mode
                        }
                }
            }
        }
    }
    
    func movementView() -> some View {
        VStack(alignment: .leading) {
            Text("세부 설정")
            
            VStack {
                
                HStack(spacing: 8) {
                    TextField("0", text: $count)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: count) { newValue in
                            count = newValue.filter { $0.isNumber }
                        }
                        .frame(width: 60) // 숫자 필드 폭
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("회")
                        .font(.headline)
                    
                    Spacer()
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))
            }
        }
        .padding()
    }
    
    func timeSettingView() -> some View {
        VStack(alignment: .leading) {
            Text("시간")
            
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        Picker("Minute", selection: $hour) {
                            ForEach(0..<24, id: \.self) { value in
                                HStack {
                                    Spacer()
                                    
                                    Text(String(format: "%02d시", value))
                                        .font(.system(size: 24, weight: .medium))
                                        .tag(value)
                                        .frame(maxWidth: .infinity)
                                    
//                                    if hour == value {
//                                        Image(systemName: "chevron.down")
//                                    }
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 120)
                        .clipped()
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    
                    VStack {
                        Picker("Minute", selection: $minute) {
                            ForEach(0..<60, id: \.self) { value in
                                HStack {
                                    Spacer()
                                    Text(String(format: "%02d분", value))
                                        .font(.system(size: 24, weight: .medium))
                                        .tag(value)
                                        .frame(maxWidth: .infinity)
                                    
//                                    if minute == value {
//                                        Image(systemName: "chevron.down")
//                                    }
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 120)
                        .clipped()
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
