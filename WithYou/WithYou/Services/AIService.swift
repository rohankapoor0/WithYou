import Foundation
import SwiftUI
import Combine

enum ReflectionStep: Hashable {
    case layer1 // Meaning Clarification
    case layer2 // Context Framing
    case layer3 // Emotional Impact
    case final  // Consolation / Validated Response
    case emergency // Panic Mode
}

class ReflectionSession: ObservableObject {

    @Published var currentResponse: AntigravityResponse? = nil
    @Published var originalCategory: String? = nil // Store for Phase 4 recall
    @Published var path: [ReflectionStep] = []
    @Published var sessionID = UUID()
    
    // Context-Aware Continuation State
    @Published var history: Set<String> = [] // IDs of options selected in previous passes
    @Published var passCount: Int = 1
    @Published var originalInput: String = "" // Store input for re-analysis
    
    // Reset for a new session (End Chat)
    func reset() {
        currentResponse = nil
        originalCategory = nil
        originalInput = ""
        path.removeAll()
        history.removeAll()
        passCount = 1
        sessionID = UUID()
    }
    
    // Continue for a second pass
    func continueSession() {
        passCount += 1
        path.removeAll()
        // We do NOT clear history or originalCategory
        // We keep currentResponse until overwritten by new analysis
    }
}
