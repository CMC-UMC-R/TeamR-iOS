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
    let rightPadding: CGFloat = 59
    let topMargin: CGFloat = 74
    
    let boardHeightRatio: CGFloat = 472 / 768
    let goalHeightRatio: CGFloat = 68 / 472
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                headerView()
                dailyIconListView()
                missionBoardView(geo.size.height * boardHeightRatio)
                buttonListView()
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
            ForEach(dailyChecklist, id: \.self) { daily in
                DailyCheckView(isChecked: daily, date: 1)
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
                    CirclesOverlay(width: geo.size.width, height: geo.size.height, leftPadding: leftPadding, rightPadding: rightPadding, topMargin: topMargin)
                    
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
            Button {
                
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
            
            Button {
                
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
}

#Preview {
    MainView()
}
