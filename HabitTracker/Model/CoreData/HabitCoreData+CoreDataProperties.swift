//
//  HabitCoreData+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Тимофей Олегович on 30.01.2025.
//
//

import Foundation
import CoreData


extension HabitCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitCoreData> {
        return NSFetchRequest<HabitCoreData>(entityName: "HabitCoreData")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var completed: Bool
    @NSManaged public var isButtonHighlighted: Bool

}

extension HabitCoreData : Identifiable {

}
