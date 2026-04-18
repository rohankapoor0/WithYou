import SwiftUI

/// Editor for creating or updating a journal entry.
struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: JournalViewModel
    
    @State private var text: String
    @State private var title: String
    
    /// If non-nil, the editor updates this entry.
    let entryToEdit: JournalEntry?
    
    init(initialContent: String, initialTitle: String = "", entryToEdit: JournalEntry?) {
        _text = State(initialValue: initialContent)
        _title = State(initialValue: initialTitle)
        self.entryToEdit = entryToEdit
    }
    
    var body: some View {
        ZStack {
            appBackground(blur: true)
            
            VStack {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.primaryText)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .accessibilityLabel("Journal text")
                
                Spacer(minLength: 0)
            }
            .glassCard()
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("Title", text: $title)
                    .font(Theme.titleFont())
                    .foregroundColor(Theme.primaryText)
                    .multilineTextAlignment(.center)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                    dismiss()
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
    
    private func save() {
        let trimmedContent = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedContent.isEmpty else { return }
        
        let finalTitle = trimmedTitle.isEmpty ? "Untitled" : trimmedTitle
        
        if let existing = entryToEdit {
            viewModel.updateEntry(existing, title: finalTitle, newContent: trimmedContent)
        } else {
            viewModel.addEntry(title: finalTitle, content: trimmedContent, source: "manual")
        }
    }
}

