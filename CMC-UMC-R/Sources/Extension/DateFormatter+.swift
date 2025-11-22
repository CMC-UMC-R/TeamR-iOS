//
//  DateFormatter+.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

func extractDayUsingFormatter(from dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = inputFormatter.date(from: dateString) else {
        return nil
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd"
    
    return outputFormatter.string(from: date)
}

//// 사용 예시
//let dateString = "2025-11-17"
//if let day = extractDayUsingFormatter(from: dateString) {
//    print(day) // 출력: 17
//}
