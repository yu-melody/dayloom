//
//  RoutineListViewModel.swift
//  dayloom
//
//  Created by Melody Yu on 11/25/24.
//

import Foundation

class RoutineListViewModel: ObservableObject {
    @Published var routines: [RoutineViewModel] = []

    private let routinesKey = "savedRoutines"

    init() {
        loadRoutines()
    }

    func saveRoutines() {
        if let encoded = try? JSONEncoder().encode(routines.map { $0.routine }) {
            UserDefaults.standard.set(encoded, forKey: routinesKey)
        }
    }

    func loadRoutines() {
        if let savedData = UserDefaults.standard.data(forKey: routinesKey),
           let decoded = try? JSONDecoder().decode([RoutineModel].self, from: savedData) {
            routines = decoded.map { routine in
                let viewModel = RoutineViewModel(routine: routine)
                viewModel.onUpdate = { [weak self] in
                    self?.saveRoutines()
                }
                return viewModel
            }
        } else {
            // Default routines with actions
            let morningActions = [
                RoutineAction(id: UUID(), type: .alarm, isEnabled: true),
                RoutineAction(id: UUID(), type: .light, isEnabled: true),
                RoutineAction(id: UUID(), type: .kettle, isEnabled: true),
                RoutineAction(id: UUID(), type: .music, isEnabled: false),
                RoutineAction(id: UUID(), type: .gratitude, isEnabled: true)
            ]

            let eveningActions = [
                RoutineAction(id: UUID(), type: .alarm, isEnabled: false),
                RoutineAction(id: UUID(), type: .light, isEnabled: true),
                RoutineAction(id: UUID(), type: .kettle, isEnabled: false),
                RoutineAction(id: UUID(), type: .music, isEnabled: true),
                RoutineAction(id: UUID(), type: .gratitude, isEnabled: false)
            ]
            
            routines = [
                RoutineViewModel(routine: RoutineModel(id: UUID(), name: "Morning Routine", time: Date(), isEnabled: true, actions: morningActions)),
                RoutineViewModel(routine: RoutineModel(id: UUID(), name: "Evening Routine", time: Date(), isEnabled: true, actions: eveningActions))
            ]

            // Set up callbacks for defaults
            routines.forEach { routine in
                routine.onUpdate = { [weak self] in
                    self?.saveRoutines()
                }
            }
        }
    }
}
