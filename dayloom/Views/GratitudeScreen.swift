//
//  GratitudeScreen.swift
//  dayloom
//
//  Created by Melody Yu on 11/9/24.
//

import SwiftUI

struct GratitudeScreen: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Gratitude Journal")
                NavigationLink(destination: AddNewEntryScreen()) {
                    Text("Add New Entry")
                }
                NavigationLink(destination: ViewPastEntriesScreen()) {
                    Text("View Past Entries")
                }
                NavigationLink(destination: SynthesizeJournalScreen()) {
                    Text("Synthesize Journal")
                }
            }
            .navigationTitle("Gratitude Journal")
        }
    }
}

#Preview {
    GratitudeScreen()
}
