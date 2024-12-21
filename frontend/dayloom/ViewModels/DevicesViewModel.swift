//
//  DevicesViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/28/24.
//


import Foundation

class DevicesViewModel: ObservableObject {
    @Published var devices: [DeviceModel] = [
        DeviceModel(name: "Small Lamp", isOn: false, category: "Lights"),
        DeviceModel(name: "Fairy Lights", isOn: false, category: "Lights"),
        DeviceModel(name: "Desk Lamp", isOn: false, category: "Lights"),
        DeviceModel(name: "Kettle", isOn: false, category: "Smart Devices")
    ]
    
    func toggleDevice(_ device: DeviceModel) {
        if let index = devices.firstIndex(where: { $0.id == device.id }) {
            devices[index].isOn.toggle()
            // Call API or send signal to IoT hardware here
        }
    }
}
