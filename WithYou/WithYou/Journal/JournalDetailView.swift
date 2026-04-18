import SwiftUI

/// Shows a single journal entry with the ability to edit it.
struct JournalDetailView: View {
    @EnvironmentObject private var viewModel: JournalViewModel
    @Binding var selectedTab: RootTabView.Tab
    
    @ObservedObject var entry: JournalEntry
    
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingEditor = false
    
    var body: some View {
        ZStack {
            appBackground(blur: true)
            
            VStack(alignment: .leading, spacing: 12) {
                // Date as Subtitle
                Text(entry.date, style: .date)
                    .font(Theme.captionFont())
                    .foregroundColor(Theme.secondaryText)
                    .padding(.horizontal)
                
                ScrollView {
                    Text(entry.content)
                        .font(Theme.bodyFont())
                        .foregroundColor(Theme.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .glassCard()
                        .padding()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(entry.title ?? "Untitled")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        showingEditor = true
                    }) {
                        Text("Edit")
                    }
                    
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red.opacity(0.7))
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditor) {
            NavigationStack {
                JournalEditorView(initialContent: entry.content, initialTitle: entry.title ?? "", entryToEdit: entry)
            }
        }
        .alert("Delete Entry?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                // Return to journals tab first
                selectedTab = .journal
                dismiss()
                
                // Perform deletion after a brief delay to allow dismissal to start
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    viewModel.deleteEntry(entry)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This cannot be undone.")
        }
    }
}

