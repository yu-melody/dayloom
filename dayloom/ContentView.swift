//
//  ContentView.swift
//  dayloom
//
//  Created by Melody Yu on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to dayloom")
                NavigationLink(destination: DeviceScreen()) {
                    Text("Go to Devices")
                }
                NavigationLink(destination: GratitudeScreen()) {
                    Text("Go to Gratitude Journal")
                }
                NavigationLink(destination: RoutineScreen()) {
                    Text("Go to Routines")
                }
            }
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    ContentView()
}
