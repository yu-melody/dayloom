//
//  EntriesViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/10/24.
//

import Foundation

class EntriesViewModel: ObservableObject {
    @Published var entries: [GratitudeEntryModel] = []
    
    private let networkManager = NetworkManager.shared


    init() {
        fetchEntries() // Load entries from the backend when the app starts
    }
    
    // Fetch all entries from the backend
    func fetchEntries() {
        // app (network manager) says: hey, can i see the list of entries?
        networkManager.fetchEntries { [weak self] fetchedEntries in
            DispatchQueue.main.async {
                // once it gets the list, it says: great! let's update the ui.
                if let fetchedEntries = fetchedEntries {
                    self?.entries = fetchedEntries
                } else {
                    print("Failed to fetch entries")
                }
            }
        }
    }

    // Add a new entry and save it to the backend
    func addEntry(_ text: String) {
        let newEntry = GratitudeEntryModel(id: UUID(), text: text, date: Date())
        networkManager.addEntry(newEntry) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.entries.append(newEntry)
                } else {
                    print("Failed to add entry")
                }
            }
        }
    }

    // Update an existing entry on the backend
    func updateEntry(id: UUID, text: String) {
        if let index = entries.firstIndex(where: { $0.id == id }) {
            var updatedEntry = entries[index]
            updatedEntry.text = text
            networkManager.updateEntry(updatedEntry) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        self?.entries[index] = updatedEntry
                    } else {
                        print("Failed to update entry")
                    }
                }
            }
        }
    }

    // Delete an entry from the backend
    func deleteEntry(id: UUID) {
        networkManager.deleteEntry(id: id) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.entries.removeAll { $0.id == id }
                } else {
                    print("Failed to delete entry")
                }
            }
        }
    }
}


