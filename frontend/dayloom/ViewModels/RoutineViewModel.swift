//
//  RoutineViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/25/24.
//

import Foundation

class RoutineViewModel: ObservableObject, Identifiable {
    var routine: RoutineModel
    @Published var isEnabled: Bool {
        didSet {
            routine.isEnabled = isEnabled
            onUpdate?() // Notify the parent
        }
    }
    @Published var time: Date {
        didSet {
            routine.time = time
            onUpdate?() // Notify the parent
        }
    }
    @Published var actions: [RoutineAction] {
        didSet {
            routine.actions = actions
            onUpdate?() // Notify the parent
        }
    }
    
    let name: String

    var onUpdate: (() -> Void)? // Closure to notify updates

    init(routine: RoutineModel) {
        self.routine = routine
        self.isEnabled = routine.isEnabled
        self.time = routine.time
        self.name = routine.name
        self.actions = routine.actions
    }
    
    
    // Update a specific action
    func toggleAction(actionId: UUID) {
        guard let index = actions.firstIndex(where: { $0.id == actionId }) else { return }
        actions[index].isEnabled.toggle()
    }
}

