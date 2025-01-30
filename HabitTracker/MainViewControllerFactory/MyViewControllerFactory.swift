import UIKit

final class MainViewControllerFactory {
    static func makeViewController() -> MainViewController {
        let dateManager = DateManager()
        let coreDataManager = CoreDataManager.shared
        let habitManager = HabitManager(coreDataManager: coreDataManager)
        let mainViewModel = MainModel(dateManager: dateManager, habitManager: habitManager)
        return MainViewController(mainViewModel: mainViewModel)
    }
}
