//
//  DeviceManager.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/23/25.
//

import SwiftUI

class DeviceManager {
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
