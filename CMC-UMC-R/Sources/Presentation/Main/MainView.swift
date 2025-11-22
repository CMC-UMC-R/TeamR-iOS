//
//  MainView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct MainView: View {
    
    var dailyChecklist: [Bool] = [true, true, true, false, false, false, false]
    
    let leftPadding: CGFloat = 52
    let rightPadding: CGFloat = 52
    let topMargin: CGFloat = 74
    
    
    var body: some View {
        VStack {
            dailyIconListView()
            missionBoardView()
            buttonListView()
        }
    }
    
    // 날짜 아이콘 리스트
    func dailyIconListView() -> some View {
        HStack {
            ForEach(dailyChecklist, id: \.self) { daily in
                dailyIconView(isChecked: true)
            }
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 12)
    }
    
    // 날짜 아이콘
    func dailyIconView(isChecked: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: "checkmark")
                .foregroundStyle(.green)
                .padding(.horizontal, 6)
                .padding(.vertical, 7)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text("11")
                .foregroundStyle(.black)
        }
        .padding(4)
        .background(.mint)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(maxWidth: .infinity)
    }
    
    func backgroundView() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.green)
    }
    
    // 미션보드
    func missionBoardView() -> some View {
        ZStack(alignment: .bottom) {
            
            missionRoadView()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            goalView()
                
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 42)
    }
    
    func missionRoadView() -> some View {
        
        RoadPathShape(leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin)
            .stroke(Color.yellow, lineWidth: 15)
            .frame(height: 472)
            .overlay {
                RoadPathShape(leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin)
                    .stroke(Color.green, lineWidth: 3)
            }
        
    }
    
    func circleView() -> some View {
        VStack {
            Circle()
                .frame(width: 82, height: 82)
                .foregroundStyle(.green)
        }
    }
    
    func goalView() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.yellow)
            .frame(height: 68)
    }
    
    func buttonListView() -> some View {
        HStack(spacing: 9) {
            Button {
                
            } label: {
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 105, height: 54)
                    .foregroundStyle(.mint)
                    .overlay {
                        Text("미션 설정")
                            .foregroundStyle(.black)
                        
                    }
                
            }
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .foregroundStyle(.green)
                    .overlay {
                        Text("미션 인증")
                            .foregroundStyle(.white)
                        
                    }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MainView()
}
