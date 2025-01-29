import UIKit

final class DateManager {
    func formatDate(date: Date, format: String = "d") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func formatMonth(date: Date, format: String = "MMM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
