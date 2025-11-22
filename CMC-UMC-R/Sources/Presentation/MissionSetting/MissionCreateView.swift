//
//  MissionCreateView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI

struct MissionCreateView: View {
    @ObservedObject var viewModel: MissionSettingViewModel
    @Binding var date: Date
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("\(viewModel.selectedCategory.displayName) 미션")
                .fontStyle(.title)
                .padding(.top, 32)
            
            Divider()
            
            categoryView()
                .opacity(viewModel.selectedCategory == .work ? 0 : 1)
                .allowsHitTesting(viewModel.selectedCategory != .work)
            
            movementView()
            
            timeSettingView()
            
            Spacer()
            
            Button {
                Task {
                    do {
                        await viewModel.saveMission()
                        
                        let scheduledDate = Calendar.current.date(
                            bySettingHour: viewModel.hour,
                            minute: viewModel.minute,
                            second: 0,
                            of: date
                        )!
                        
                        let identifier = try await NotificationManager.shared.scheduleMissionNotification(
                            at: scheduledDate,
                            title: "하루틴",
                            subtitle: "미션 알림",
                            body: "지금은 \(viewModel.selectedCategory.displayName) 미션하러 갈 시간!",
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
                    .background(Color.primary700)
//                    .background(viewModel.word.isEmpty || viewModel.count.isEmpty ? Color.gray : Color.primary700)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func categoryView() -> some View {
        HStack {
            ForEach(MissionType.allCases, id: \.self) { mode in
                Text("\(mode.displayName)")
                    .fontStyle(.display3)
                    .foregroundColor(viewModel.selectedType == mode ? Color.gray400 : Color.primary100)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        viewModel.selectedType == mode
                        ? Color.primary700
                        : Color.primary500
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        viewModel.selectedType = mode
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func movementView() -> some View {
        VStack(alignment: .leading) {
            if viewModel.selectedType == .move {
                Text(viewModel.selectedCategory == .wakeup ? "움직임" : "걸음")
                    .fontStyle(.main1)
                    .foregroundStyle(Color.primary900)
                
                VStack {
                    HStack {
                        TextField("00", text: $viewModel.count)
                            .fontStyle(.main4)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: viewModel.count) { newValue, _ in
                                viewModel.count = newValue.filter { $0.isNumber }
                            }
                        
                        Text(viewModel.selectedCategory == .wakeup ? "회" : "보")
                            .fontStyle(.main4)
                        
                        Spacer()
                    }
                    
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                }
            } else {
                Text("세부 설정")
                    .fontStyle(.main1)
                    .foregroundStyle(Color.primary900)
                
                Menu {
                    ForEach(viewModel.selectedCategory.geminiCategories, id: \.self) { category in
                        Button {
                            viewModel.selectedGeminiCategory = category
                        } label: {
                            Text(category.displayName)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedGeminiCategory?.displayName ?? "카테고리 선택")
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.3))

            }
        }
        .padding()
    }
    
    func timeSettingView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("시간")
                .fontStyle(.main1)
                .foregroundStyle(Color.primary900)
            
            VStack(spacing: 0) {
                HStack {
                    hourPickerView()
                    minutePickerView()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
    
    func hourPickerView() -> some View {
        VStack {
            Picker("Hour", selection: $viewModel.hour) {
                ForEach(0..<24, id: \.self) { value in
                    HStack {
                        Spacer()
                        
                        Text(String(format: "%02d시", value))
                            .fontStyle(.main4)
                            .tag(value)
                            .frame(maxWidth: .infinity)
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
    
    func minutePickerView() -> some View {
        VStack {
            Picker("Minute", selection: $viewModel.minute) {
                ForEach(0..<60, id: \.self) { value in
                    HStack {
                        Spacer()
                        Text(String(format: "%02d분", value))
                            .fontStyle(.main4)
                            .tag(value)
                            .frame(maxWidth: .infinity)
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
