//
//  CharactersTarget.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Alamofire
import Moya

enum CharactersTarget {
    case getMe
}

extension CharactersTarget: BaseTargetType {
    var path: String {
        switch self {
        case .getMe:
            CharactersAPI.getMe.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMe:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMe:
            return .requestPlain
        }
    }
}
