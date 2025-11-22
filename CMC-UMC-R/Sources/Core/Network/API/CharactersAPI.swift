//
//  CharactersAPI.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation

enum CharactersAPI {
    case getMe
}

extension CharactersAPI {
    var path: String {
        switch self {
        case .getMe:
            return "characters/me"
        }
    }
}
