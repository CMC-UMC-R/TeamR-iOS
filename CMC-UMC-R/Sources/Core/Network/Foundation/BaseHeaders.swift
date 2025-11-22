//
//  BaseHeaders.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

import Foundation

struct BaseHeaders {
    static let xDeviceId = "X-Device-Id"
    
}

extension BaseHeaders {
    static var baseHeaders: Dictionary<String, String> {
        [
            // TODO: UUID 가져오는 함수 연결
            xDeviceId : ""
        ]
    }
}
