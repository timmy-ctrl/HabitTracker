import UIKit

final class MainViewController: UIViewController {
    
    private let mainModel: MainModel

    private var mainView: MainView? {
        view as? MainView
    }
    
    init(mainViewModel: MainModel) {
        self.mainModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainVC()
        loadHabits()
        resetDailyHabits()
    }
    
    override func loadView() {
        self.view = MainView(mainViewModel: mainModel)
    }
    
    private func transitionToCreatingHabitVC() {
        setAddNavigationBarButton()
    }
    
    private func loadHabits() {
        let habits = mainModel.habitManager?.fetchHabits()
        mainView?.habits = habits ?? []
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
extension MainViewController: habitUpdateDelegate {
    func didAddNewHabit(_ habit: Habit) {
        mainView?.habits.append(habit)
        DispatchQueue.main.async { [weak self] in
            self?.mainView?.tableView.reloadData()
        }
    }
}
