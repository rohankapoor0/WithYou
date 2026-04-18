import Foundation
import CoreData

/// Core Data stack configured entirely in code to avoid external model files.
/// Stores only on-device, aligning with the local-first requirement.
final class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        let model = PersistenceController.makeModel()
        container = NSPersistentContainer(name: "WithYouModel", managedObjectModel: model)
        
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [description]
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // In a production app you would handle this more gracefully.
                print("Unresolved Core Data error: \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Defines the Core Data model for `JournalEntry`.
    private static func makeModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let journalEntity = NSEntityDescription()
        journalEntity.name = "JournalEntry"
        journalEntity.managedObjectClassName = "JournalEntry"
        
        // Attributes
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        
        let dateAttribute = NSAttributeDescription()
        dateAttribute.name = "date"
        dateAttribute.attributeType = .dateAttributeType
        dateAttribute.isOptional = false
        
        let contentAttribute = NSAttributeDescription()
        contentAttribute.name = "content"
        contentAttribute.attributeType = .stringAttributeType
        contentAttribute.isOptional = false
        
        let sourceAttribute = NSAttributeDescription()
        sourceAttribute.name = "source"
        sourceAttribute.attributeType = .stringAttributeType
        sourceAttribute.isOptional = false
        
        let createdAtAttribute = NSAttributeDescription()
        createdAtAttribute.name = "createdAt"
        createdAtAttribute.attributeType = .dateAttributeType
        createdAtAttribute.isOptional = false
        
        // NEW: Title Attribute
        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.attributeType = .stringAttributeType
        titleAttribute.isOptional = true
        
        journalEntity.properties = [
            idAttribute,
            dateAttribute,
            contentAttribute,
            sourceAttribute,
            createdAtAttribute,
            titleAttribute
        ]
        
        model.entities = [journalEntity]
        return model
    }
}

