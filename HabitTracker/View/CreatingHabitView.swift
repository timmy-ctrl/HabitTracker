import UIKit
import SnapKit

final class CreatingHabitView: UIView {
    
 public let habitNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название привычки"
        return textField
    }()
    
    public let createHabitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать привычку", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI
extension CreatingHabitView {
    
    private func setView() {
        setColorBG()
        setHabitNameTextField()
        setCreateHabitButton()
    }
    
    private func setColorBG() {
        self.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 48/255, alpha: 100/255)
    }
    
    private func setHabitNameTextField() {
        self.addSubview(habitNameTextField)
        habitNameTextField.snp.makeConstraints({ habitNameTextField in
            habitNameTextField.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            habitNameTextField.leading.equalToSuperview().inset(20)
            habitNameTextField.trailing.equalToSuperview().inset(-20)
        })
    }
    
    private func setCreateHabitButton() {
        self.addSubview(createHabitButton)
        createHabitButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}

