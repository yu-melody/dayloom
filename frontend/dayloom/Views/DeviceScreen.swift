//
//  DeviceScreen.swift
//  dayloom
//
//  Created by Melody Yu on 11/9/24.
//

import SwiftUI

struct DeviceScreen: View {
    @StateObject private var viewModel = DevicesViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            TitleText(text: "Devices")

            Divider()
                .background(Color("EarthyTitleColor").opacity(0.5))

            // Group devices by category
            ForEach(Array(groupedDevices()), id: \.key) { category, devices in
                VStack(alignment: .leading, spacing: 8) {
                    // Category Header
                    Text(category)
                        .font(.headline)
                        .foregroundColor(Color("EarthyTitleColor"))
                        .padding(.leading)

                    // Device List
                    ForEach(devices, id: \.id) { device in
                        HStack {
                            Text(device.name)
                                .font(.body)
                                .foregroundColor(Color("EarthyTitleColor"))
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { device.isOn },
                                set: { _ in viewModel.toggleDevice(device) }
                            ))
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: Color("EarthyAccentColor")))
                        }
                        .padding()
                        .background(Color("EarthyCardBackground"))
                        .cornerRadius(10)
                    }

                }
            }

            Spacer()
        }
        .padding()
        .background(Color("EarthyBackground").edgesIgnoringSafeArea(.all))
    }

    // Group devices by category
    private func groupedDevices() -> [String: [DeviceModel]] {
        Dictionary(grouping: viewModel.devices, by: { $0.category })
    }
}
