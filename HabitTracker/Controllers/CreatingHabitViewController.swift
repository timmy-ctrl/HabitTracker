import UIKit

final class CreatingHabitViewController: UIViewController {
    
    weak var addHabitDelegate: AddHabitDelegate?
    
    private var creatingHabitView: CreatingHabitView? {
        view as? CreatingHabitView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createHabbit()
    }
    
    override func loadView() {
        self.view = CreatingHabitView()
    }
    
    private func createHabbit() {
        creatingHabitView?.createHabitButton.addTarget(self, action: #selector(didPressedButton), for: .touchUpInside)
    }
}

//MARK: - @objc
extension CreatingHabitViewController {
    @objc private func didPressedButton() {
        guard let title = creatingHabitView?.habitNameTextField.text, !title.isEmpty else { return }
        let newHabit = Habit(id: UUID(),
                             title: title,
                             description: "",
                             trackedDays: [],
                             completedToday: false,
                             isButtonHighlighted: false)
        CoreDataManager.shared.createHabit(from: newHabit)
        addHabitDelegate?.didAddNewHabit(newHabit)
        navigationController?.popToRootViewController(animated: true)
    }
}


