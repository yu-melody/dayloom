//
//  RoutineModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/25/24.
//


// RoutineModel.swift
import Foundation

struct RoutineModel: Identifiable, Codable {
    let id: UUID
    var name: String // Routine name (e.g., "Morning Routine")
    var time: Date // Scheduled time for the routine
    var isEnabled: Bool // Whether the routine is active
    var actions: [RoutineAction] // List of actions in the routine
}

struct RoutineAction: Identifiable, Codable {
    let id: UUID
    var type: RoutineActionType // Type of action (e.g., alarm, light, kettle)
    var isEnabled: Bool // Whether the action is part of the routine
}

enum RoutineActionType: String, Codable {
    case alarm
    case light
    case kettle
    case music
    case gratitude
}
