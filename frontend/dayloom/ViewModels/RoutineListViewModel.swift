import Foundation

class RoutineListViewModel: ObservableObject {
    @Published var routines: [RoutineViewModel] = []

    init() {
        fetchRoutines()
    }

    func fetchRoutines() {
        NetworkManager.shared.fetchRoutines { [weak self] fetchedRoutines in
            DispatchQueue.main.async {
                if let fetchedRoutines = fetchedRoutines {
                    self?.routines = fetchedRoutines.map { routine in
                        let viewModel = RoutineViewModel(routine: routine)
                        viewModel.onUpdate = { [weak self] in
                            self?.updateRoutine(viewModel.routine)
                        }
                        return viewModel
                    }
                } else {
                    print("Failed to fetch routines")
                }
            }
        }
    }

    func updateRoutine(_ routine: RoutineModel) {
        NetworkManager.shared.updateRoutine(routine) { success in
            if success {
                print("Routine updated successfully")
            } else {
                print("Failed to update routine")
            }
        }
    }
}
