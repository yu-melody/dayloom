//
//  NetworkManager.swift
//  dayloom
//
//  Created by Melody Yu on 12/21/24.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://fastapi-app-270357093577.us-east1.run.app"
    lazy private var baseGratitudeURL = "\(baseURL)/gratitude"
    
    // Fetch all entries
    // completion is the closure: it executes once the network request is complete.
    func fetchEntries(completion: @escaping ([GratitudeEntryModel]?) -> Void) {
        guard let url = URL(string: baseGratitudeURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching entries: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601  // Configure for ISO8601 dates
                let entries = try decoder.decode([GratitudeEntryModel].self, from: data)
                completion(entries)
            } catch {
                print("Error decoding entries: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Add a new entry
    func addEntry(_ entry: GratitudeEntryModel, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseGratitudeURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONEncoder().encode(entry)
            request.httpBody = body
        } catch {
            print("Error encoding entry: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error adding entry: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    // Update an entry
    func updateEntry(_ entry: GratitudeEntryModel, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseGratitudeURL)/\(entry.id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = try JSONEncoder().encode(entry)
            request.httpBody = body
        } catch {
            print("Error encoding entry: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) {_, response, error in
            if let error = error {
                print("Error updating entry: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    // Delete an entry
    func deleteEntry(id: UUID, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseGratitudeURL)/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error deleting entry: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
}
