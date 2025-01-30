import UIKit

final class CreatingHabitViewController: UIViewController {
    
    weak var addHabitDelegate: habitUpdateDelegate?

    private var creatingHabitView: CreatingHabitView? {
        view as? CreatingHabitView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
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
        HabitManager.shared.createHabit(from: newHabit)
        addHabitDelegate?.didAddNewHabit(newHabit)
        navigationController?.popToRootViewController(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension CreatingHabitViewController: UITextFieldDelegate {
    
    func setDelegates() {
        creatingHabitView?.habitNameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        creatingHabitView?.habitNameTextField.resignFirstResponder()
        return true
    }
    
}
