//
//  Font+.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import SwiftUI

struct FontStyle {
    let font: Font
    let fontName: String
    let size: CGFloat
    let lineHeight: CGFloat
    
    private var uiFont: UIFont {
        if fontName == "System" {
            return .systemFont(ofSize: size)
        }
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    }
    
    var lineSpacing: CGFloat {
        max(0, lineHeight - uiFont.lineHeight)
    }
    
    var verticalPadding: CGFloat {
        lineSpacing / 2
    }
}

extension FontStyle {
    static let display1 = FontStyle(font: .custom("Pretendard-Bold", size: 42), fontName: "Pretendard-Bold", size: 42, lineHeight: 42 * 1.0)
    static let display2 = FontStyle(font: .custom("Pretendard-Bold", size: 32), fontName: "Pretendard-Bold", size: 22, lineHeight: 28 * 1.5)
    
    static let main1 = FontStyle(font: .custom("Pretendard-Medium", size: 18), fontName: "Pretendard-Medium", size: 18, lineHeight: 18 * 1.5)
    static let main2 = FontStyle(font: .custom("Pretendard-Medium", size: 16), fontName: "Pretendard-Medium", size: 16, lineHeight: 16 * 1.5)
    static let main3 = FontStyle(font: .custom("Pretendard-Medium", size: 14), fontName: "Pretendard-Medium", size: 14, lineHeight: 14 * 1.5)
    
    static let caption = FontStyle(font: .custom("Pretendard-Regular", size: 12), fontName: "Pretendard-Regular", size: 12, lineHeight: 12 * 1.0)
    
    static let title = FontStyle(font: .custom("Pretendard-SemiBold", size: 24), fontName: "Pretendard-SemiBold", size: 24, lineHeight: 24 * 1.5)
}
