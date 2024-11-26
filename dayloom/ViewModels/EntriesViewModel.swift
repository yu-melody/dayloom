//
//  EntriesViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/10/24.
//

import SwiftUI

class GratitudeEntry: Identifiable, ObservableObject {
    let id = UUID()
    @Published var text: String
    let date: Date

    init(text: String, date: Date) {
        self.text = text
        self.date = date
    }
}


class EntriesViewModel: ObservableObject {
    @Published var entries: [GratitudeEntry] = []

    func addEntry(_ text: String) {
        let newEntry = GratitudeEntry(text: text, date: Date())
        entries.append(newEntry)
    }
    
    // Update entry function
    func updateEntry(id: UUID, text: String) {
            if let index = entries.firstIndex(where: { $0.id == id }) {
                entries[index].text = text
                print("Updated entry at index \(index) with text: \(text)")
            }
        }
    
    // Deletes the entry
    func deleteEntry(id: UUID) {
        entries.removeAll { $0.id == id }  // Remove entry with matching ID
    }
}


