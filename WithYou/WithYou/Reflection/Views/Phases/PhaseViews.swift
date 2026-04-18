import SwiftUI

// MARK: - Emergency View
struct EmergencyView: View {
    let response: AntigravityResponse
    @ObservedObject var session: ReflectionSession
    @State private var showSuccess = false
    
    var body: some View {
        ZStack {
            appBackground(blur: true)
            
            VStack(spacing: 24) {
                if showSuccess {
                    // Success State
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green.opacity(0.8))
                            .padding()
                        
                        Text("Look at you. You did it.")
                            .font(Theme.titleFont())
                            .foregroundColor(Theme.primaryText)
                            .multilineTextAlignment(.center)
                        
                        Text("I know that felt like a storm that would never end, but you rode the wave and made it to the shore. I am so, so proud of you.\n\nPlease be gentle with yourself for the rest of the day—fighting off panic is like running a marathon. Drink a sip of water, shake out your shoulders, and just exist. You are safe.")
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: { session.reset() }) {
                            Text("Done")
                                .font(Theme.bodyFont().bold())
                                .foregroundColor(Theme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .glassCard(cornerRadius: 30)
                        }
                    }
                } else {
                    // Panic State
                    VStack(spacing: 20) {
                        if let header = response.empathyHeader {
                            Text(header)
                                .font(.headline)
                                .foregroundColor(Color.red.opacity(0.8))
                        }
                        
                        if let validation = response.validationText {
                            Text(validation)
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.primaryText)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(12)
                        }
                        
                        if let body = response.actionCardBody {
                            Text(body)
                                .font(Theme.titleFont())
                                .foregroundColor(Theme.primaryText)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        Spacer()
                        
                        if let options = response.options {
                            ForEach(options) { option in
                                Button(action: {
                                    if option.id == "better" {
                                        withAnimation { showSuccess = true }
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: option.icon)
                                        Text(option.title)
                                    }
                                    .font(Theme.bodyFont().bold())
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .glassCard(cornerRadius: 30)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Layer Components
// Shared View for Layers 1, 2, 3
struct LayerView: View {
    let title: String
    let response: AntigravityResponse
    @ObservedObject var session: ReflectionSession
    let onNext: (String?) -> Void // OptionID? (nil if skipped)
    
    var body: some View {
        ZStack {
            appBackground(blur: true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header (Category)
                    if response.phase == 1 {
                        Text(response.detectedCategory ?? "")
                            .font(Theme.captionFont())
                            .padding(8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .foregroundColor(Theme.accentColor)
                    }
                    
                    if let validation = response.validationText {
                        Text(validation)
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.primaryText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .glassCard()
                    }
                    
                    if let question = response.questionText {
                        Text(question)
                            .font(Theme.titleFont())
                            .foregroundColor(Theme.primaryText)
                            .padding(.top)
                    }
                    
                    VStack(spacing: 12) {
                        if let options = response.options {
                            ForEach(options) { option in
                                Button(action: {
                                    handleSelection(optionId: option.id)
                                }) {
                                    HStack(spacing: 16) {
                                        Image(systemName: option.icon)
                                            .font(.title2)
                                            .foregroundColor(Theme.accentColor)
                                            .frame(width: 32)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(option.title)
                                                .font(Theme.bodyFont().bold())
                                                .foregroundColor(Theme.primaryText)
                                            Text(option.subtitle)
                                                .font(Theme.captionFont())
                                                .foregroundColor(Theme.secondaryText)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Theme.secondaryText.opacity(0.5))
                                    }
                                    .padding()
                                    .glassCard(cornerRadius: 30)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        handleSelection(optionId: nil) // Skip
                    }) {
                        Text("Skip this layer")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.secondaryText)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
        .navigationTitle(title)
        .navigationBarBackButtonHidden(false)
    }
    
    private func handleSelection(optionId: String?) {
        triggerHaptic(type: "light")
        onNext(optionId)
    }
}

// MARK: - Final View (Consolation)
struct FinalView: View {
    let response: AntigravityResponse
    @ObservedObject var session: ReflectionSession
    @EnvironmentObject var journalViewModel: JournalViewModel
    @State private var isSaved = false
    
    var body: some View {
        ZStack {
            appBackground(blur: true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header Image/Icon
                    HStack {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Theme.accentColor)
                            .padding()
                            .glassCard(cornerRadius: 100) // Circular
                        Spacer()
                    }
                    
                    // The Consolation
                    if let consolation = response.actionCardBody {
                        Text(consolation)
                            .font(Theme.titleFont())
                            .lineSpacing(6)
                            .foregroundColor(Theme.primaryText)
                            .padding()
                            .glassCard()
                    }
                    
                    if let summary = response.summaryText {
                        Text(summary)
                            .font(Theme.bodyFont())
                            .foregroundColor(Theme.secondaryText)
                            .italic()
                            .padding(.horizontal)
                    }
                    
                    if let tips = response.nextTimeTips {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Reflections")
                                .font(.headline)
                                .foregroundColor(Theme.primaryText)
                            
                            ForEach(tips) { tip in
                                HStack {
                                    Image(systemName: tip.icon)
                                        .foregroundColor(Theme.accentColor)
                                    Text(tip.text)
                                        .font(Theme.captionFont())
                                        .foregroundColor(Theme.secondaryText)
                                }
                            }
                        }
                        .padding()
                        .glassCard()
                    }
                    
                    // Save & Done
                    Button(action: saveToJournal) {
                        HStack {
                            Image(systemName: isSaved ? "checkmark" : "bookmark")
                            Text(isSaved ? "Saved" : "Save Reflection")
                        }
                        .foregroundColor(isSaved ? .green : Theme.accentColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .glassCard(cornerRadius: 30) // Pill
                    }
                    .disabled(isSaved)
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            // Context-Aware Continuation
                            session.continueSession()
                            
                            // Re-Analyze
                            if let nextResponse = PerspectiveEngine.analyze(
                                input: session.originalInput,
                                passCount: session.passCount,
                                history: session.history
                            ) {
                                session.currentResponse = nextResponse
                                session.path.append(.layer1)
                            }
                        }) {
                            Text("Continue your chat")
                                .font(Theme.bodyFont().bold())
                                .foregroundColor(Theme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .glassCard(cornerRadius: 30) // Pill
                        }
                        
                        Button(action: {
                            session.reset()
                        }) {
                            Text("End chat")
                                .font(Theme.bodyFont())
                                .foregroundColor(Theme.primaryText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.accentColor.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            triggerHaptic(type: "success")
        }
    }
    
    private func saveToJournal() {
        let title = "Insight: \(session.originalCategory ?? "Reflection")"
        let body = response.actionCardBody ?? ""
        journalViewModel.addEntry(title: title, content: body, source: "reflection")
        triggerHaptic(type: "success")
        isSaved = true
    }
}

// MARK: - Helpers
func triggerHaptic(type: String?) {
    let generator = UINotificationFeedbackGenerator()
    switch type {
    case "success": generator.notificationOccurred(.success)
    case "error": generator.notificationOccurred(.error)
    case "light": UIImpactFeedbackGenerator(style: .light).impactOccurred()
    case "medium": UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    case "heavy": UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    default: break
    }
}
