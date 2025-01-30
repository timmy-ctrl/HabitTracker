import UIKit

protocol DateDisplayable: AnyObject {
    func displayDate(dateString: Date)
}

protocol habitUpdateDelegate: AnyObject {
    func didAddNewHabit(_ habit: Habit)
}
