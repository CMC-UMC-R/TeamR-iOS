//
//  RoadMapView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct CirclesOverlay: View {
    let width: CGFloat
    let height: CGFloat
    
    let leftPadding: CGFloat
    let rightPadding: CGFloat
    let topMargin: CGFloat
    
    let response: MissionLogListResponse
    
    var body: some View {

        let verticalGap: CGFloat = 95

        ZStack {
            // 원 1 (시작점 - 왼쪽 위)
            
            MissionCircleView(mission: .start, result: .START)
                .position(x: leftPadding, y: topMargin)

            MissionCircleView(mission: .wakeup, result: response.logList[0].missionStatus)
                .position(x: width - rightPadding, y: topMargin + verticalGap)

            MissionCircleView(mission: .move, result: response.logList[1].missionStatus)
                .position(x: leftPadding, y: topMargin + verticalGap * 2)

            MissionCircleView(mission: .work, result: response.logList[2].missionStatus)
                .position(x: width - rightPadding, y: topMargin + verticalGap * 2.5)
        }
    }
}
