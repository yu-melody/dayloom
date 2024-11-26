//
//  RoutineModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/25/24.
//


import Foundation

struct RoutineModel: Identifiable, Codable { // Codable allows RoutineModel to be converted into a format that can be saved (like JSON)
    let id = UUID() // Unique identifier
    var name: String // Routine name (e.g., "Morning Routine")
    var time: Date = Date() // Default time
    var isEnabled: Bool = false // Whether the routine is active
}
