//
//  Color+.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/22/25.
//

import SwiftUI

extension Color {
    
    static let primary100: Color = .init(hex: "FFFFFF")
    static let primary400: Color = .init(hex: "F4FAF5")
    static let primary500: Color = .init(hex: "C8E9CB")
    static let primary600: Color = .init(hex: "97DD9F")
    static let primary700: Color = .init(hex: "61D673")
    static let primary800: Color = .init(hex: "29D049")
    static let primary900: Color = .init(hex: "29D049")
    
    static let sub300: Color = .init(hex: "FBF3DB")
    static let sub400: Color = .init(hex: "FAEDA3")
    static let sub500: Color = .init(hex: "FFF566")
    static let sub600: Color = .init(hex: "FBFF2E")
    static let sub700: Color = .init(hex: "DCF500")
    static let sub800: Color = .init(hex: "9ABD00")
    static let sub900: Color = .init(hex: "618500")
    
    static let gray100: Color = .init(hex: "9F9F9F")
    static let gray200: Color = .init(hex: "838383")
    static let gray300: Color = .init(hex: "676767")
    static let gray400: Color = .init(hex: "4B4B4B")
    static let gray500: Color = .init(hex: "3B3B3B")
    static let gray600: Color = .init(hex: "0F1710")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
