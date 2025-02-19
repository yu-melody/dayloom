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
//    private let baseURL = "http://192.168.1.36:8000"
    lazy private var baseGratitudeURL = "\(baseURL)/gratitude"
    lazy private var baseRoutineURL = "\(baseURL)/routines"
    
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Use ISO 8601 format for dates
            let body = try encoder.encode(entry)
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Use ISO 8601 format for dates
            let body = try encoder.encode(entry)
            request.httpBody = body
        } catch {
            print("Error encoding entry: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
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
    
    func fetchRoutines(completion: @escaping ([RoutineModel]?) -> Void) {
        guard let url = URL(string: "\(baseRoutineURL)/") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let routines = try decoder.decode([RoutineModel].self, from: data) // Expecting an array
                    completion(routines)
                } catch {
                    print("Error decoding routines: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching routines: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
        task.resume()
    }

    
    // Update a routine
    func updateRoutine(_ routine: RoutineModel, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseRoutineURL)/\(routine.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(routine)
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("Error updating routine: \(error)")
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Failed to update routine")
                    completion(false)
                    return
                }
                
                completion(true)
            }.resume()
        } catch {
            print("Error encoding routine: \(error)")
            completion(false)
        }
    }
}
