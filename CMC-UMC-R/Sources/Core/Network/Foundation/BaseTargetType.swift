//
//  BaseTargetType.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

import Foundation
import Moya

public protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    public var baseURL: URL {
        return URL(string: BaseAPI.base.path)!
    }
    
    public var headers: [String : String]? {
        return BaseHeaders.baseHeaders
    }
    
}
