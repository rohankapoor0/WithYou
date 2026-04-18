import SwiftUI

/// Lists all journal entries in reverse chronological order.
struct JournalListView: View {
    @EnvironmentObject private var viewModel: JournalViewModel
    @Binding var selectedTab: RootTabView.Tab
    
    @State private var showingNewEntry = false
    
    var body: some View {

        ZStack {
            appBackground(blur: true)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    if viewModel.entries.isEmpty {
                        VStack(spacing: 12) {
                            Text("Your journal is empty.")
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.secondaryText)
                                .multilineTextAlignment(.center)
                            Text("You can write anything here: thoughts, reflections, or insights from conversations.")
                                .font(Theme.captionFont())
                                .foregroundColor(Theme.secondaryText)
                                .multilineTextAlignment(.center)
                        }
                        .padding(40)
                    } else {
                        ForEach(viewModel.entries, id: \.id) { entry in
                            NavigationLink(destination: JournalDetailView(selectedTab: $selectedTab, entry: entry)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(entry.title ?? "Untitled")
                                                .font(Theme.titleFont())
                                                .foregroundColor(Theme.primaryText)
                                            
                                            Text(entry.date, style: .date)
                                                .font(Theme.captionFont())
                                                .foregroundColor(Theme.secondaryText)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundColor(Theme.secondaryText.opacity(0.5))
                                            .padding(.top, 4)
                                    }
                                    
                                    Text(entry.content)
                                        .font(Theme.bodyFont())
                                        .foregroundColor(Theme.secondaryText) // Secondary for preview
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding()
                                .glassCard()
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Journal")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingNewEntry = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(Theme.accentColor)
                }
                .accessibilityLabel("New journal entry")
            }
        }
        .sheet(isPresented: $showingNewEntry) {
            NavigationStack {
                JournalEditorView(initialContent: "", initialTitle: "", entryToEdit: nil)
            }
        }
        .onAppear {
            viewModel.fetchEntries()
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let entry = viewModel.entries[index]
            viewModel.deleteEntry(entry)
        }
    }
}

