import SwiftUI
import Combine

/// Calm, welcoming home screen for WithYou.
/// Shows logo, time-based greeting, and gentle prompt.
struct HomeView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var showVideo: Bool = true
    @State private var currentDate: Date = Date()
    
    private var isRunningOnSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: currentDate)
        switch hour {
        case 5..<12:
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }
    
    var body: some View {
        ZStack {
            if !isRunningOnSimulator && showVideo {
                VideoBackgroundView(videoName: "home_bg")
                    .ignoresSafeArea()
            } else {
                LinearGradient(
                    colors: [Color.black, Color.gray.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }

            // Dark overlay for readability
            Color.black.opacity(0.25)
                .ignoresSafeArea()

            // App Logo & Greeting - Perfectly Centered
            VStack(spacing: 20) {
                Image("homeWY")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5) // Soft float shadow
                
                // Greeting Floating on Gradient
                VStack(spacing: 8) {
                    Text(greeting)
                        .font(Theme.titleFont())
                        .foregroundColor(Theme.primaryText)
                    
                    Text("What’s on your mind?")
                        .font(Theme.bodyFont())
                        .foregroundColor(Theme.secondaryText)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Footer hint
            VStack {
                Spacer()
                Text("You can talk, write, or reflect — whenever you want.")
                    .font(Theme.captionFont())
                    .foregroundColor(Theme.secondaryText)
                    .padding(.bottom, 40)
                    .opacity(0.8)
            }
        }
        .onReceive(
            Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        ) { date in
            currentDate = date
        }
        .onChange(of: scenePhase) {
            showVideo = (scenePhase == .active)
        }
    }
}
