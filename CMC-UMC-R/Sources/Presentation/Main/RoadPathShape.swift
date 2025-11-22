//
//  RoadPathShape.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

struct RoadPathShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // 고정 여백
        let leftPadding: CGFloat = 50
        let rightPadding: CGFloat = 50
        let topMargin: CGFloat = 70
        
        // 남은 높이를 3등분
        let remainingHeight = height - topMargin
        let verticalGap = remainingHeight / 5
        
        // 곡선 반경 (도로 두께와 동일하게)
        let curveRadius: CGFloat = 30
        
        let point1 = CGPoint(x: leftPadding, y: topMargin)
        
        let point2 = CGPoint(x: width - rightPadding, y: topMargin)

        let point3 = CGPoint(x: width - rightPadding, y: topMargin + verticalGap)

        let point4 = CGPoint(x: leftPadding, y: topMargin + verticalGap)
        
        let point5 = CGPoint(x: leftPadding, y: point4.y + verticalGap)
        
        let point6 = CGPoint(x: width - rightPadding, y: point5.y)
        
        let point7 = CGPoint(x: width - rightPadding, y: point6.y + verticalGap * 1.5)
        
        
        
        // Path 그리기 시작
        path.move(to: point1)
        
        // 첫 번째 수평 구간 (원1 → 원2 방향)
        path.addLine(to: CGPoint(x: point2.x - curveRadius, y: point1.y))
        
        // 첫 번째 90도 꺾임 (오른쪽에서 아래로)
        path.addQuadCurve(
            to: CGPoint(x: point2.x , y: point2.y + curveRadius),
            control: point2
        )
        
        // 두 번째 수평 구간 (오른쪽 → 왼쪽)
        path.addLine(to: CGPoint(x: point3.x, y: point3.y - curveRadius))
        
        // 두 번째 90도 꺾임 (왼쪽에서 아래로)
        path.addQuadCurve(
            to: CGPoint(x: point3.x - curveRadius, y: point3.y),
            control: CGPoint(x: point3.x, y: point3.y)
        )

        path.addLine(to: CGPoint(x: point4.x + curveRadius, y: point3.y))
        
        path.addQuadCurve(
            to: CGPoint(x: point4.x, y: point4.y + curveRadius),
            control: CGPoint(x: point4.x, y: point4.y)
        )
        
        path.addLine(to: CGPoint(x: point5.x, y: point5.y - curveRadius))
        
        path.addQuadCurve(
            to: CGPoint(x: point5.x + curveRadius, y: point5.y),
            control: CGPoint(x: point5.x, y: point5.y)
        )
        
        path.addLine(to: CGPoint(x: point6.x - curveRadius, y: point6.y))
        
        path.addQuadCurve(
            to: CGPoint(x: point6.x, y: point6.y + curveRadius),
            control: CGPoint(x: point6.x, y: point6.y)
        )
        
        path.addLine(to: CGPoint(x: point7.x, y: point7.y))

        
        return path
    }
}

#Preview {
    RoadPathShape()
        .stroke(Color.yellow, lineWidth: 15)
}
