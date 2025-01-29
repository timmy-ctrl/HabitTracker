import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    
    func createHabit(from habit: Habit) {
        let habitEntity = HabitCoreData(context: context)
        habitEntity.name = habit.title
        habitEntity.id = habit.id
        habitEntity.completed = habit.completedToday
        habitEntity.isButtonHighlighted = habit.isButtonHighlighted
        saveContext()
    }
    
    func fetchHabits() -> [Habit] {
        let request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        do {
            let habits = try context.fetch(request)
            return habits.map { Habit(id: $0.id,
                                      title: $0.name!,
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
            let habits = try context.fetch(request)
            if let habit = habits.first {
                context.delete(habit)
                saveContext()
            }
        } catch {
            print("Ошибка удаления привычки: \(error)")
        }
    }
    
    func updateHabit(_ habit: Habit) {
        let request: NSFetchRequest<HabitCoreData> = HabitCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
        
        do {
            let habits = try context.fetch(request)
            if let habitEntity = habits.first {
                habitEntity.name = habit.title
                habitEntity.id = habit.id
                habitEntity.completed = habit.completedToday
                habitEntity.isButtonHighlighted = habit.isButtonHighlighted
                saveContext()
            }
        } catch {
            print("Ошибка обновления привычки: \(error)")
        }
    }
}
