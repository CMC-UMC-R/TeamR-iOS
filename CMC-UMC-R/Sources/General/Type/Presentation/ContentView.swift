//
//  ContentView.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunch: Bool = true
    
    var body: some View {
        if isLaunch {
            LaunchView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isLaunch = false
                    }
                }
        } else {
            MainView(mainViewModel: MainViewModel())
        }
    }
}

#Preview {
    ContentView()
}
