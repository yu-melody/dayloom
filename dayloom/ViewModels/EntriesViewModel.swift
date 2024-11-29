//
//  EntriesViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/10/24.
//

import Foundation

class EntriesViewModel: ObservableObject {
    @Published var entries: [GratitudeEntryModel] = []

    private let entriesKey = "GratitudeEntries"

    init() {
        loadEntries() // Load entries when the app starts
    }

    // Add a new entry
    func addEntry(_ text: String) {
        let newEntry = GratitudeEntryModel(id: UUID(), text: text, date: Date())
        entries.append(newEntry)
        saveEntries()
    }

    // Update an existing entry
    func updateEntry(id: UUID, text: String) {
        if let index = entries.firstIndex(where: { $0.id == id }) {
            entries[index].text = text
            saveEntries()
        }
    }

    // Delete an entry
    func deleteEntry(id: UUID) {
        entries.removeAll { $0.id == id }
        saveEntries()
    }

    // Save entries to UserDefaults
    private func saveEntries() {
        // Replace UserDefaults logic with cloud database logic later
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(entries) {
            UserDefaults.standard.set(encoded, forKey: entriesKey)
        }
    }

    // Load entries from UserDefaults
    private func loadEntries() {
        // Replace UserDefaults logic with cloud database logic later
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: entriesKey),
           let decoded = try? decoder.decode([GratitudeEntryModel].self, from: savedData) {
            entries = decoded
        }
    }
}




