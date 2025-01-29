import UIKit

final class MainViewController: UIViewController {

    private var mainView: MainView? {
        view as? MainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainVC()
        loadHabits()
        resetDailyHabits()
    }
    
    override func loadView() {
        let dateManager = DateManager()
        let mainViewModel = MainViewModel(dateManager: dateManager)
        self.view = MainView(mainViewModel: mainViewModel)
    }
    
    private func transitionToCreatingHabitVC() {
        setAddNavigationBarButton()
    }
    
    private func loadHabits() {
        let habits = CoreDataManager.shared.fetchHabits()
        mainView?.habits = habits
        for habit in habits {
            print("Loaded habit: \(habit.title), isButtonHighlighted: \(habit.isButtonHighlighted)")
        }
        mainView?.tableView.reloadData()
    }
    
    private func resetDailyHabits() {
        for index in 0..<(mainView?.habits.count ?? 0) {
            mainView?.habits[index].resetDailyCompletion()
        }
        mainView?.tableView.reloadData()
    }
}

//MARK: - Setup UI
extension MainViewController {
    
    private func setMainVC() {
        transitionToCreatingHabitVC()
        setNavigationBarAppereance()
    }
    
    private func setAddNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTappedAddNavigationBarButton))
    }
    
    private func setNavigationBarAppereance() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - @Objc
extension MainViewController {
    @objc private func didTappedAddNavigationBarButton() {
        let creatingHabiitVC = CreatingHabitViewController()
        creatingHabiitVC.addHabitDelegate = self
        self.navigationController?.pushViewController(creatingHabiitVC, animated: true)
    }
}

//MARK: - AddHabitDelegate
extension MainViewController: AddHabitDelegate {
    func didAddNewHabit(_ habit: Habit) {
        mainView?.habits.append(habit)
        DispatchQueue.main.async { [weak self] in
            self?.mainView?.tableView.reloadData()
        }
    }
}
