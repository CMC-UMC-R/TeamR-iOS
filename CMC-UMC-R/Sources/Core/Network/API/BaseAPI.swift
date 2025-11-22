//
//  BaseAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum BaseAPI: String {
    case base
    
    var path: String {
        switch self {
        case .base:
            return "http://34.64.201.186:8080/api/"
        }
    }
}
