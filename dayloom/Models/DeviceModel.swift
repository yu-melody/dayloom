//
//  DeviceModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/28/24.
//


import Foundation

struct DeviceModel: Identifiable {
    let id = UUID()
    var name: String
    var isOn: Bool
    var category: String // e.g., "Lights", "Smart Devices"
}
