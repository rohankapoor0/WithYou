//
//  WithYouApp.swift
//  WithYou
//
//  Created by rohan kapoor on 02/02/26.
//

import SwiftUI
import CoreData

/// Root application entry point for WithYou.
/// Sets up shared dependencies and the main tab-based interface.
@main
struct WithYouApp: App {
    
    // MARK: - Core Data
    private let persistenceController = PersistenceController.shared
    
    // MARK: - Shared State / Services
    @StateObject private var journalViewModel: JournalViewModel
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var reflectionSession = ReflectionSession()
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        // Initialize view models with required dependencies
        _journalViewModel = StateObject(wrappedValue: JournalViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            RootTabView(reflectionSession: reflectionSession)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(journalViewModel)
                .environmentObject(notificationManager)
                .onAppear {
                    // Ensure initial notification configuration is in sync with settings.
                    notificationManager.syncWithStoredPreference()
                }
        }
    }
}

/// The main tab view for the application.
struct RootTabView: View {
    @EnvironmentObject private var notificationManager: NotificationManager
    @ObservedObject var reflectionSession: ReflectionSession
    
    enum Tab {
        case home
        case reflection
        case journal
        case settings
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(Tab.home)
            
            NavigationStack(path: $reflectionSession.path) {
                DescribeView(session: reflectionSession)
                    .navigationDestination(for: ReflectionStep.self) { step in
                        if let response = reflectionSession.currentResponse {
                            switch step {
                            case .layer1:
                                LayerView(title: "Clarify", response: response, session: reflectionSession) { optionId in
                                    // Track history
                                    if let id = optionId { reflectionSession.history.insert(id) }
                                    
                                    // Move to Layer 2
                                    if let next = PerspectiveEngine.processLayer1Selection(optionId: optionId ?? "skip", currentResponse: response, passCount: reflectionSession.passCount, history: reflectionSession.history) {
                                        reflectionSession.currentResponse = next
                                        reflectionSession.path.append(.layer2)
                                    }
                                }
                            case .layer2:
                                LayerView(title: "Context", response: response, session: reflectionSession) { optionId in
                                    // Track history
                                    if let id = optionId { reflectionSession.history.insert(id) }
                                    
                                    let category = reflectionSession.originalCategory ?? "general"
                                    
                                    if let next = PerspectiveEngine.processLayer2Selection(answerId: optionId ?? "skip", categoryString: category, passCount: reflectionSession.passCount, history: reflectionSession.history) {
                                        reflectionSession.currentResponse = next
                                        reflectionSession.path.append(.layer3)
                                    }
                                }
                            case .layer3:
                                LayerView(title: "Impact", response: response, session: reflectionSession) { optionId in
                                    // Track history
                                    if let id = optionId { reflectionSession.history.insert(id) }
                                    
                                    // Move to Final
                                    if let next = PerspectiveEngine.processLayer3Completion(currentResponse: response, originalCategory: reflectionSession.originalCategory) {
                                        reflectionSession.currentResponse = next
                                        reflectionSession.path.append(.final)
                                    }
                                }
                            case .final:
                                FinalView(response: response, session: reflectionSession)
                            case .emergency:
                                EmergencyView(response: response, session: reflectionSession)
                            }
                        } else {
                            // Fallback if response is missing (should not happen)
                            Text("Something went wrong. Please try again.")
                        }
                    }
            }
            .tabItem {
                Label("Reflect", systemImage: "sparkles")
            }
            .tag(Tab.reflection)
            
            NavigationStack {
                JournalListView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Journal", systemImage: "book.closed")
            }
            .tag(Tab.journal)
            
            NavigationStack {
                SettingsView(selectedTab: $selectedTab)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            .tag(Tab.settings)
        }
        .accentColor(Theme.accentColor)
    }
}
