import Foundation
import CoreData

/// Core Data managed object representing a single journal entry.
@objc(JournalEntry)
public class JournalEntry: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var content: String
    @NSManaged public var title: String?
    @NSManaged public var source: String
    @NSManaged public var createdAt: Date
}

