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
            routines = [
                RoutineViewModel(routine: RoutineModel(name: "Morning Routine")),
                RoutineViewModel(routine: RoutineModel(name: "Evening Routine"))
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
