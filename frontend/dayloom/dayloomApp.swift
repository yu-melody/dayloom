//
//  dayloomApp.swift
//  dayloom
//
//  Created by Melody Yu on 11/9/24.
//

import SwiftUI

@main
struct dayloomApp: App {
    @StateObject private var viewModel = EntriesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)  // Injects EntriesViewModel to all views
        }
    }
}
