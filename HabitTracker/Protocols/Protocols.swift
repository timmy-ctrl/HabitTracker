import UIKit

protocol DateDisplayable: AnyObject {
    func displayDate(dateString: Date)
}

protocol AddHabitDelegate: AnyObject {
    func didAddNewHabit(_ habit: Habit)
}
