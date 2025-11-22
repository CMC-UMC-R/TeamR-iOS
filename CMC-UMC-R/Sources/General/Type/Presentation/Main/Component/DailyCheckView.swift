//
//  DailyCheckView.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

struct DailyCheckView: View {
    
    let isChecked: Bool
    let date: Int
    
    var body: some View {
        VStack(spacing: 4) {
            if isChecked {
                Image(.checkmark)
                    .frame(width: 24, height: 24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(.xmark)
                    .frame(width: 24, height: 24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
                
            Text("\(date)")
                .foregroundStyle(.black)
        }
        .padding(4)
        .background(Color.primary500)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(maxWidth: .infinity)
    }
}

#Preview("true") {
    DailyCheckView(isChecked: true, date: 1)
}

#Preview("failure") {
    DailyCheckView(isChecked: false, date: 1)
}
