import UIKit
import CoreData


final class HabitManager {
    
    static let shared = HabitManager()
    
     private let coreDataManager: CoreDataManager?
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func createHabit(from habit: Habit) {
        guard let context = coreDataManager?.context else { return }
        let habitEntity = HabitCoreData(context: coreDataManager?.context ?? context)
        habitEntity.name = habit.title
        habitEntity.id = habit.id
        habitEntity.completed = habit.completedToday
        habitEntity.isButtonHighlighted = habit.isButtonHighlighted
        coreDataManager?.saveContext()
    }
    
    func fetchHabits() -> [Habit] {
        let request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        do {
            guard let habits = try coreDataManager?.context.fetch(request) else {
                return []
            }
            return habits.map { Habit(id: $0.id,
                                      title: $0.name ?? "Без названия",
                                      description: "",
                                      trackedDays: [],
                                      completedToday: $0.completed,
                                      isButtonHighlighted: $0.isButtonHighlighted
            )}
        } catch {
            print("Ошибка загрузки привычек: \(error)")
            return [] }
    }
    
    func deleteHabit(with id: UUID) {
        let request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let habits = try coreDataManager?.context.fetch(request)
            if let habit = habits?.first {
                coreDataManager?.context.delete(habit)
                coreDataManager?.saveContext()
            }
        } catch {
            print("Ошибка удаления привычки: \(error)")
        }
    }
    
    func updateHabit(_ habit: Habit) {
        let request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
        
        do {
            let habits = try coreDataManager?.context.fetch(request)
            if let habitEntity = habits?.first {
                habitEntity.name = habit.title
                habitEntity.id = habit.id
                habitEntity.completed = habit.completedToday
                habitEntity.isButtonHighlighted = habit.isButtonHighlighted
                coreDataManager?.saveContext()
            }
        } catch {
            print("Ошибка обновления привычки: \(error)")
        }
    }
}
