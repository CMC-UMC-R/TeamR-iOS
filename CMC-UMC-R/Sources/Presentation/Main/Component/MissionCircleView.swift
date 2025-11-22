//
//  MissionCircleView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

struct MissionCircleView: View {
    
    let mission: MissionType
    let result: MissionResultType
    
    var body: some View {
        Group {
            if mission == .start {
                VStack(spacing: 4) {
                    Circle()
                        .frame(width: 41, height: 41)
                        .foregroundStyle(Color.primary900)
                        .overlay {
                            result.iconImage
                                .offset(y: -5)
                        }
                    Text("\(mission.rawValue)")
                        .foregroundStyle(Color.gray400)
                        .fontStyle(.caption)

                }
            } else {
                Circle()
                    .frame(width: 82, height: 82)
                    .foregroundStyle(Color.primary900)
                    .overlay {
                        result.iconImage
                    }
                    .overlay {
                        Text("\(mission.rawValue)")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4.5)
                            .background(Color.primary100)
                            .foregroundStyle(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(y: 40)
                            .fontStyle(.caption)
                        
                    }
            }
        }
            
    }
}

#Preview("Start") {
    MissionCircleView(mission: .start, result: .currentStart)
}

#Preview("Complete") {
    MissionCircleView(mission: .activity, result: .current)
}
