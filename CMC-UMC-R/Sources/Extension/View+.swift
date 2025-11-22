//
//  View+.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

extension View {
    
    // 폰트 line height 적용
    /*
     <사용법>
     Text("Hello World!)
     .fontStyle(.num1)
     */
    func fontStyle(_ style: FontStyle) -> some View {
        self
            .font(style.font)
            .lineSpacing(style.lineSpacing)
            .padding(.vertical, style.verticalPadding)
    }
}
