//
//  LaunchView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/23/25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        Image("LaunchImage")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    LaunchView()
}
