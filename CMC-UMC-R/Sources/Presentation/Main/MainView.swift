//
//  MainView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct MainView: View {
    
    var dailyChecklist: [Bool] = [true, true, true, false, false, false, false]
    
    let leadingPadding: Int = 50
    let trailingPadding: Int = 50
    let topPadding: Int = 70

    
    var body: some View {
        VStack {
            dailyIconListView()
            missionBoardView()
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
        
        ZStack {
            
            backgroundView()
            
            GeometryReader { geometry in
                missionRoadView(geometry.size.width, geometry.size.height)
            }
            
            
        }
        .padding(.horizontal, 20)
    }
    
    func missionRoadView(_ width: Double, _ height: Double) -> some View {
        RoadPathShape()
            .stroke(Color.yellow, lineWidth: 15)
        
    }
}

#Preview {
    MainView()
}
