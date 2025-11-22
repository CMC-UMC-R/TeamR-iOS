//
//  Date+Extension.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

extension Date {
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }
}
