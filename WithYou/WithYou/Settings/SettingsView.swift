import SwiftUI

/// Settings for notifications, privacy, and data controls.
struct SettingsView: View {
    @EnvironmentObject private var journalViewModel: JournalViewModel
    @EnvironmentObject private var notificationManager: NotificationManager
    
    /// Binding to the selected tab so we can, if needed, direct the user back to Home.
    @Binding var selectedTab: RootTabView.Tab
    
    @State private var showingClearJournalAlert = false
    
    var body: some View {

        ZStack {
            Theme.liquidGlassGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Daily Check-in Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily check-in")
                            .font(.headline)
                            .freshHeading()
                        
                        Toggle(isOn: Binding(
                            get: { notificationManager.isDailyCheckInEnabled },
                            set: { newValue in
                                notificationManager.setDailyCheckInEnabled(newValue)
                            })
                        ) {
                            Text("Gentle daily invitation")
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.primaryText)
                        }
                        .tint(Theme.accentColor)
                        
                        Text("Sends one gentle notification per day, inviting you to talk if you want to. No streaks, pressure, or goals.")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.secondaryText)
                    }
                    .padding()
                    .glassCard()
                    
                    // Data Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Data")
                            .font(.headline)
                            .freshHeading()
                        
                        Button(role: .destructive) {
                            showingClearJournalAlert = true
                        } label: {
                            HStack {
                                Text("Clear all journal entries")
                                    .foregroundColor(.red.opacity(0.8))
                                Spacer()
                                Image(systemName: "trash")
                                    .foregroundColor(.red.opacity(0.6))
                            }
                        }
                        .alert("Clear all journal entries?", isPresented: $showingClearJournalAlert) {
                            Button("Delete", role: .destructive) {
                                journalViewModel.clearAll()
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("This removes all saved journal content from this device. This cannot be undone.")
                        }
                    }
                    .padding()
                    .glassCard()
                    
                    // Privacy Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Privacy")
                            .font(.headline)
                            .freshHeading()
                        
                        Text("WithYou stores your journal and settings only on this device. There are no accounts, no public profiles, and no social features.")
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.secondaryText)
                        
                        Text("This app works entirely offline. No data is ever sent to any server.")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.secondaryText.opacity(0.7))
                    }
                    .padding()
                    .glassCard()
                }
                .padding()
            }
        }
        .navigationTitle("Settings")
        .scrollContentBackground(.hidden)
    }
}

