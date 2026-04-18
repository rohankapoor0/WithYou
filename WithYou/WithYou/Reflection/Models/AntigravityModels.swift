import Foundation

// MARK: - Core Response Model
struct AntigravityResponse: Codable {
    let phase: Int
    let hapticFeedback: String? // "light", "medium", "success"
    
    // Phase 1 Fields
    let empathyHeader: String?
    let detectedCategory: String?
    
    // Phase 2 Fields
    let validationText: String?
    let questionText: String?
    
    // Phase 3 Fields
    let actionCardTitle: String?
    let actionCardBody: String?
    
    // Phase 4 Fields
    let summaryText: String?
    let dailyAnchor: String?
    let closingMessage: String?
    let nextTimeTips: [Tip]?
    
    // Shared Options (Used in Phase 1, 2, 3)
    let options: [AntigravityOption]?
    
    // Coding Keys for JSON mapping
    enum CodingKeys: String, CodingKey {
        case phase, options
        case hapticFeedback = "haptic_feedback"
        case empathyHeader = "empathy_header"
        case detectedCategory = "detected_category"
        case validationText = "validation_text"
        case questionText = "question_text"
        case actionCardTitle = "action_card_title"
        case actionCardBody = "action_card_body"
        case summaryText = "summary_text"
        case dailyAnchor = "daily_anchor"
        case closingMessage = "closing_message"
        case nextTimeTips = "next_time_tips"
    }
}

// MARK: - Option Model
struct AntigravityOption: Codable, Identifiable, Hashable {
    let id: String
    let icon: String
    let title: String
    let subtitle: String
}

// MARK: - Tip Model
struct Tip: Codable, Identifiable, Hashable {
    var id: UUID { UUID() }
    let icon: String
    let text: String
    
    // Custom coding keys to exclude ID from JSON decoding if needed, 
    // but default synthesized Codable works if we ignore ID on decode or make it optional.
    // For simplicity, we implement init(from decoder) to generate a UUID locally.
    
    private enum CodingKeys: String, CodingKey {
        case icon, text
    }
    
    init(icon: String, text: String) {
        self.icon = icon
        self.text = text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.icon = try container.decode(String.self, forKey: .icon)
        self.text = try container.decode(String.self, forKey: .text)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(icon, forKey: .icon)
        try container.encode(text, forKey: .text)
    }
}
