import UIKit

struct Habit {
    let id: UUID
    let title: String
    let description: String
    var trackedDays: [Date]
    var completedToday: Bool = false
    var isButtonHighlighted: Bool = false
    
    var currentStreak: Int {
        return trackedDays.count
    }
    
    mutating func markAsCompleted() {
        completedToday.toggle()
        if completedToday {
            trackedDays.append(Date())
        } else {
            trackedDays.removeLast()
        }
    }
    
    mutating func resetDailyCompletion() {
        completedToday = false
    }
}
