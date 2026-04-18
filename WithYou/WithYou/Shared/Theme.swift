import SwiftUI
import UIKit

/// Shared visual theme for WithYou.
/// Uses system colors and Dynamic Type friendly fonts.
struct Theme {
    // MARK: - Color Helpers
    static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        Color(uiColor: UIColor { $0.userInterfaceStyle == .dark ? dark : light })
    }
    
    // MARK: - Soft Blue & Airy Palette
    // Sky Blue: The base background color for Light Mode. Airy and calm.
    static let skyBlue = UIColor(red: 0.85, green: 0.94, blue: 0.98, alpha: 1.0)
    
    // Soft Teal: Gentle accent gradient end.
    static let softTeal = UIColor(red: 0.75, green: 0.92, blue: 0.95, alpha: 1.0)
    
    // Muted Navy: Primary text color for Light Mode. Readable but softer than black.
    static let mutedNavy = UIColor(red: 0.2, green: 0.3, blue: 0.45, alpha: 1.0)
    
    // Deep Ocean: Dark Mode background base.
    static let deepOcean = UIColor(red: 0.05, green: 0.1, blue: 0.25, alpha: 1.0)
    
    // Rich Teal: Dark Mode gradient end.
    static let richTeal = UIColor(red: 0.0, green: 0.3, blue: 0.4, alpha: 1.0)
    
    static let accentColor: Color = dynamicColor(
        light: UIColor(red: 0.2, green: 0.5, blue: 0.65, alpha: 1.0), // Muted Dark Teal
        dark: UIColor(red: 0.4, green: 0.8, blue: 0.9, alpha: 1.0)    // Bright Cyan
    )
    
    // Gradients
    static var liquidGlassGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                dynamicColor(light: skyBlue, dark: deepOcean),
                dynamicColor(light: softTeal, dark: richTeal)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static let backgroundColor: Color = Color.clear
    
    // Text Logic
    static let primaryText: Color = dynamicColor(
        light: mutedNavy,
        dark: UIColor.white.withAlphaComponent(0.95)
    )
    
    static let secondaryText: Color = dynamicColor(
        light: mutedNavy.withAlphaComponent(0.7),
        dark: UIColor.white.withAlphaComponent(0.7)
    )
    
    // Special Style for Headings (Settings/Journal Titles)
    static func headingStyle() -> some ViewModifier {
        HeadingModifier()
    }
    
    static let glassGlow: Color = dynamicColor(
        light: UIColor.white.withAlphaComponent(0.5), // Soft white glow in Light Mode
        dark: UIColor.cyan.withAlphaComponent(0.3)   // Cyan glow in Dark Mode
    )
    
    // MARK: - Fonts
    static func titleFont() -> Font {
        .system(.title2, design: .rounded).weight(.semibold)
    }
    
    static func bodyFont() -> Font {
        .system(.body, design: .rounded)
    }
    
    static func captionFont() -> Font {
        .system(.footnote, design: .rounded)
    }
}

// Heading Modifier (Adapts to White/Navy)
struct HeadingModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .white : Theme.primaryText) // Use Navy in light mode
            .shadow(
                color: Color.black.opacity(colorScheme == .light ? 0.05 : 0.15),
                radius: 2, x: 0, y: 1
            )
    }
}

// MARK: - Refined Glass Modifier (Soft Card Style)
struct GlassModifier: ViewModifier {
    var cornerRadius: CGFloat = 24
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial) // Maintain blur for depth
            .backgroundColor(
                colorScheme == .light
                ? Color.white.opacity(0.75) // Tinted Off-White Card (Reference Match)
                : Color.white.opacity(0.1)  // Dark Glass
            )
            .cornerRadius(cornerRadius)
            .shadow(
                color: Color.black.opacity(colorScheme == .light ? 0.05 : 0.2), // Soft shadow
                radius: 12,
                x: 0,
                y: 4
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(LinearGradient(
                        colors: [
                            .white.opacity(colorScheme == .light ? 0.0 : 0.3), // No border in Light Mode
                            .white.opacity(colorScheme == .light ? 0.0 : 0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ), lineWidth: colorScheme == .light ? 0 : 1) // 0 width in Light Mode
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 24) -> some View {
        self.modifier(GlassModifier(cornerRadius: cornerRadius))
    }
    
    // Global App Background Helper
    @ViewBuilder
    func appBackground(blur: Bool = true) -> some View {
        ZStack {
            // User-provided Background Image
            Image("GlobalBackground")
                .resizable()
                .ignoresSafeArea()
                // If blur is requested, apply a heavy blur to create the soft aesthetic
                // If not requested (Home?), we show it clear (or maybe Home has its own bg?)
                // The user asked for "blurred version" for Reflect/Journal/Settings.
                // Assuming 'blur=true' is passed for those screens.
                .blur(radius: blur ? 60 : 0)
                .overlay(
                     // Optional overlay to ensure text contrast if image is too light/dark
                     Color.black.opacity(0.1)
                )
        }
        .background(Theme.liquidGlassGradient) // Fallback
    }
    
    // Helper to blend background material with tint
    func backgroundColor(_ color: Color) -> some View {
        self.background(color)
    }
    
    // Standard Heading Style
    func freshHeading() -> some View {
        self.modifier(Theme.headingStyle())
    }
}
