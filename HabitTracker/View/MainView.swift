import UIKit
import SnapKit

final class MainView: UIView {
    
    private let mainViewModel: MainModel
    
    public var habits: [Habit] = []
   
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor =  .clear
        tableView.separatorColor = .clear
        return tableView
       }()
    
    private var monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(mainViewModel: MainModel) {
        self.mainViewModel = mainViewModel
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI
extension MainView {
    
    private func setView() {
        setColorBG()
        setDate()
        setDateLabelConstraints()
        setMonthabelConstraints()
        setTableView()
    }
    
    private func setColorBG() {
        self.backgroundColor = UIColor(red: 42/255, green: 41/255, blue: 48/255, alpha: 100/255)
    }
   
    private func setDateLabelConstraints() {
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ dateLabel in
            dateLabel.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            dateLabel.leading.equalToSuperview().inset(20)
        })
    }
    
    private func setMonthabelConstraints() {
        self.addSubview(monthLabel)
        monthLabel.snp.makeConstraints({ monthLabel in
            monthLabel.top.equalTo(self.safeAreaLayoutGuide).inset(48)
            monthLabel.leading.equalTo(self.dateLabel.snp.trailing).offset(10)
        })
    }
    
    private func setTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(self.safeAreaLayoutGuide).inset(100)
            tableView.leading.equalToSuperview()
            tableView.trailing.equalToSuperview()
            tableView.bottom.equalToSuperview()
        }
    }
}

//MARK: - DateDisplayable

extension MainView: DateDisplayable {
    
    func displayDate(dateString: Date) {
        let formattedDay = mainViewModel.dateManager?.formatDate(date: dateString)
        let formattedMonth = mainViewModel.dateManager?.formatMonth(date: dateString)
        dateLabel.text = formattedDay
        monthLabel.text = formattedMonth
    }
    
    private func setDate() {
        let currentDate = Date()
        displayDate(dateString: currentDate)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func deleteHabit(at indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        habits.remove(at: indexPath.row)
        HabitManager.shared.deleteHabit(with: habit.id)
        tableView.deleteRows(at: [indexPath], with: .none)
    }
    
    func updatedHabit(_ updateHabit: Habit) {
        if let index = habits.firstIndex(where: {$0.id == updateHabit.id}) {
            habits[index] = updateHabit
            HabitManager.shared.updateHabit(updateHabit)
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as? HabitTableViewCell else {
                   return UITableViewCell()
               }
      
        let habit = habits[indexPath.row]
        cell.configure(with: habit) { [weak self] updatedHabit in
            self?.updatedHabit(updatedHabit)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               deleteHabit(at: indexPath)
           }
       }
}
