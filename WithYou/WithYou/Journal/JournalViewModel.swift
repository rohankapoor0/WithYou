import Foundation
import Combine
import CoreData

/// View model responsible for all journal-related operations.
/// Uses Core Data and exposes a simple, observable API to views.
final class JournalViewModel: ObservableObject {
    @Published private(set) var entries: [JournalEntry] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /// Loads all journal entries sorted by date (most recent first).
    func fetchEntries() {
        let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \JournalEntry.date, ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            entries = try context.fetch(request)
        } catch {
            print("Failed to fetch journal entries: \(error)")
            entries = []
        }
    }
    
    /// Creates a new journal entry.
    func addEntry(title: String, content: String, source: String) {
        let entry = JournalEntry(context: context)
        entry.id = UUID()
        entry.date = Date()
        entry.title = title
        entry.content = content
        entry.source = source
        entry.createdAt = Date()
        
        saveIfNeeded()
    }
    
    /// Updates an existing entry's content and date.
    func updateEntry(_ entry: JournalEntry, title: String, newContent: String) {
        entry.title = title
        entry.content = newContent
        entry.date = Date()
        saveIfNeeded()
    }
    
    /// Deletes a specific entry.
    func deleteEntry(_ entry: JournalEntry) {
        context.delete(entry)
        saveIfNeeded()
    }
    
    /// Clears all journal data. This is irreversible.
    func clearAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = JournalEntry.fetchRequest()
        let batchDelete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(batchDelete)
            try context.save()
            entries = []
        } catch {
            print("Failed to clear journal entries: \(error)")
        }
    }
    
    // MARK: - Private Helpers
    
    private func saveIfNeeded() {
        guard context.hasChanges else { return }
        do {
            try context.save()
            fetchEntries()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

