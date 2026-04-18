import SwiftUI

struct DescribeView: View {
    @ObservedObject var session: ReflectionSession
    @State private var situationDescription: String = ""
    
    var body: some View {
        ZStack {
            // Blurred background for consistency
            appBackground(blur: true)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("What happened?")
                    .font(Theme.titleFont())
                    .foregroundColor(Theme.primaryText)
                    .padding(.top, 20)
                
                Text("Take a moment to describe the situation. Just the facts, or how it felt.")
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.secondaryText)
                
                // Input Box - Pill Shape & Smaller Height
                TextEditor(text: $situationDescription)
                    .scrollContentBackground(.hidden)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.primaryText)
                    .padding()
                    .frame(height: 120) // Reduced height
                    .background(Color.white.opacity(0.05)) // Inner faint tint
                    .clipShape(RoundedRectangle(cornerRadius: 30)) // Pill shape logic
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Theme.glassGlow, lineWidth: 1)
                            .opacity(0.3)
                    )
                    .shadow(color: Theme.glassGlow, radius: 8, x: 0, y: 0) // Glow
                    .padding(.vertical, 20)
                
                Spacer()
                
                Button(action: {
                    if let response = PerspectiveEngine.analyze(input: situationDescription) {
                        session.currentResponse = response
                        session.originalCategory = response.detectedCategory
                        session.originalInput = situationDescription
                        
                        // Navigate
                        if response.phase == 0 {
                            session.path.append(ReflectionStep.emergency)
                        } else {
                            session.path.append(ReflectionStep.layer1)
                        }
                    }
                }) {
                    Text("Continue")
                        .font(Theme.bodyFont().bold())
                        .foregroundColor(Theme.primaryText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .glassCard(cornerRadius: 30) // Consistent pill radius
                }
                .disabled(situationDescription.isEmpty)
                .opacity(situationDescription.isEmpty ? 0.6 : 1.0)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: session.sessionID) { _ in
            situationDescription = ""
        }
    }
}

#Preview {
    NavigationStack {
        DescribeView(session: ReflectionSession())
    }
}
