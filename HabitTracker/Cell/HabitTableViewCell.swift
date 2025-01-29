import UIKit
import SnapKit

final class HabitTableViewCell: UITableViewCell {
    
    static var identifier: String {
        get {
            "HabitTableViewCell"
        }
    }
    
    private var currentHabit: Habit?
    private var onComplete: ((Habit) -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let streakLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var completeButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            button.tintColor = .systemGreen
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with habit: Habit, onComplete: @escaping(Habit) -> Void) {
        currentHabit = habit
        titleLabel.text = habit.title
        self.onComplete = onComplete
        updateButtonAppereance(habit)
        
    }
}

//MARK: - Setup UI
extension HabitTableViewCell {
    private func setViewCell() {
        setBackgroungColor()
        setTitleLabel()
        setCompleteButton()
        selectionStyle = .none
    }
    
    private func setBackgroungColor()  {
        self.backgroundColor = UIColor(red: 42/255, green: 41/255, blue: 48/255, alpha: 100/255)
    }
 
    private func setTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { titleLabel in
            titleLabel.top.equalTo(contentView).offset(8)
            titleLabel.leading.equalTo(contentView).offset(15)
        }
    }
    
    private func setCompleteButton() {
        contentView.addSubview(completeButton)
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        completeButton.snp.makeConstraints { completeButton in
            completeButton.top.equalTo(contentView).offset(10)
            completeButton.trailing.equalTo(contentView).offset(-10)
        }
    }
    
    private func updateButtonAppereance(_ habit: Habit) {
        completeButton.isSelected = habit.completedToday
        completeButton.tintColor = habit.isButtonHighlighted ? .green : .white
    }
}

//MARK: - @Objc
extension HabitTableViewCell {
    @objc private func completeButtonTapped() {
        guard var habit = currentHabit else { return }
        habit.isButtonHighlighted.toggle()
        CoreDataManager.shared.updateHabit(habit)
        onComplete?(habit)
    }
}
