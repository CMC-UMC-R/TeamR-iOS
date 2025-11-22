//
//  RoadMapView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct RoadMapView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 도로 그리기
                RoadPathShape()
                    .stroke(
                        Color.yellow,
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round,
                            lineJoin: .round,
                            dash: [20, 15]
                        )
                    )
                
                // 원 4개 배치
//                CirclesOverlay(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct CirclesOverlay: View {
    let width: CGFloat
    let height: CGFloat
    
    let leftPadding: CGFloat
    let rightPadding: CGFloat
    let topMargin: CGFloat
    
    var body: some View {
        let leftPadding: CGFloat = 52
        let rightPadding: CGFloat = 52
        let topMargin: CGFloat = 74
        
//        let remainingHeight = height - topMargin
        let verticalGap: CGFloat = 98
        
        let circleRadius: CGFloat = 30
        
        ZStack {
            // 원 1 (시작점 - 왼쪽 위)
            Circle()
                .fill(Color.green.opacity(0.3))
                .frame(width: circleRadius * 2, height: circleRadius * 2)
                .position(x: leftPadding, y: topMargin)
            
            // 원 2 (오른쪽 위)
            Circle()
                .fill(Color.green.opacity(0.3))
                .stroke(Color.yellow, lineWidth: 3)
                .frame(width: circleRadius * 2, height: circleRadius * 2)
                .position(x: width - rightPadding, y: topMargin)
            
            // 원 3 (왼쪽 중간)
            Circle()
                .fill(Color.green.opacity(0.3))
                .stroke(Color.yellow, lineWidth: 3)
                .frame(width: circleRadius * 2, height: circleRadius * 2)
                .position(x: leftPadding, y: topMargin + verticalGap)
            
            // 원 4 (오른쪽 아래)
            Circle()
                .fill(Color.green.opacity(0.3))
                .stroke(Color.yellow, lineWidth: 3)
                .frame(width: circleRadius * 2, height: circleRadius * 2)
                .position(x: width - rightPadding, y: topMargin + verticalGap * 2)
        }
    }
}
