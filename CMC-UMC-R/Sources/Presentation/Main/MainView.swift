//
//  MainView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct MainView: View {
    
    var dailyChecklist: [Bool] = [true, true, true, false, false, false, false]
    
    var body: some View {
        VStack {
            dailyIconListView()
            missionBoardView()
        }
    }
    
    // 날짜 아이콘
    func dailyIconListView() -> some View {
        HStack {
            ForEach(dailyChecklist, id: \.self) { daily in
                dailyIconView(isChecked: true)
            }
        }
    }
    
    // 날짜 아이콘 리스트
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
    
    // 미션보드
    func missionBoardView() -> some View {
        ZStack {
            
        }
    }
    
    func missionRoadView() -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            
        }
    }
}

#Preview {
    MainView()
}
