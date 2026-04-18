import Foundation

/// Logic for "The Antigravity Perspective Engine".
struct PerspectiveEngine {
    
    /// Analyzes the user's input text and returns Phase 1 Response.
    static func analyze(input: String, passCount: Int = 1, history: Set<String> = []) -> AntigravityResponse? {
        let normalizedInput = input.lowercased()
        var detectedCategory: ContextCategory? = nil
        
        // Pathway Checks
        // Priority 0: Emergency / Panic
        if containsAny(input: normalizedInput, triggers: ["panic", "can't breathe", "dying", "heart racing", "help", "emergency", "freaking out", "shaking", "scared"]) {
            return ContentGenerator.generateEmergency()
        }
        
        // Priority 1: Grief & Failure
        if containsAny(input: normalizedInput, triggers: ["died", "passed away", "lost my", "funeral", "grief", "killed", "dead", "loss of", "missing him", "missing her", "mourning"]) { detectedCategory = .grief }
        else if containsAny(input: normalizedInput, triggers: ["failed", "exam", "test", "fired", "bad grade", "lost job", "rejected", "didn't get in", "mess up", "failure", "loser"]) { detectedCategory = .failure }
        
        // Priority 2: Core Social & Conflict
        else if containsAny(input: normalizedInput, triggers: ["fight", "yelled", "screamed", "argued", "mad", "angry", "rude", "hostile", "snapped", "shouting"]) { detectedCategory = .conflict }
        else if containsAny(input: normalizedInput, triggers: ["left out", "ignored", "no invite", "rejected", "forgotten", "didn't ask me", "excluded", "uninvited"]) { detectedCategory = .exclusion }
        else if containsAny(input: normalizedInput, triggers: ["left on read", "no reply", "ghosted", "...", "k.", "dry text", "seen", "blue ticks", "ignoring me"]) { detectedCategory = .digital }
        else if containsAny(input: normalizedInput, triggers: ["weird vibe", "sarcastic", "weird look", "serious", "mean joke", "stare", "cold", "off", "tone"]) { detectedCategory = .tone }
        else if containsAny(input: normalizedInput, triggers: ["failing", "stupid", "everyone else", "better than me", "behind", "grades", "internship", "winner", "smarter", "unsuccessful"]) { detectedCategory = .comparison }
        else if containsAny(input: normalizedInput, triggers: ["awkward", "cringe", "said something dumb", "mistake", "embarrassed", "shouldn't have said", "idiot"]) { detectedCategory = .socialGuilt }
        else if containsAny(input: normalizedInput, triggers: ["what if", "scared", "nervous", "future", "interview", "date", "presentation", "dread", "fail"]) { detectedCategory = .futureAnxiety }
        else if containsAny(input: normalizedInput, triggers: ["unfair", "i was on time", "punished", "not my fault", "team late", "debarred", "disqualified", "rules", "blamed"]) { detectedCategory = .unjust }
        
        // Priority 3: Nuanced / Neurodivergent Social
        else if containsAny(input: normalizedInput, triggers: ["misunderstood", "wrong idea", "didn't mean it", "took it wrong", "interpreted", "twisted my words", "badly explained"]) { detectedCategory = .misunderstood }
        else if containsAny(input: normalizedInput, triggers: ["offended", "hurt feelings", "wrong thing", "upset them", "rude accidentally", "didn't realize", "foot in mouth"]) { detectedCategory = .accidentalOffense }
        else if containsAny(input: normalizedInput, triggers: ["masking", "faking", "pretending", "exhausted", "acting normal", "fit in", "fake smile", "hiding"]) { detectedCategory = .masking }
        else if containsAny(input: normalizedInput, triggers: ["eye contact", "looking at eyes", "staring", "looked away", "where to look"]) { detectedCategory = .eyeContact }
        else if containsAny(input: normalizedInput, triggers: ["sarcasm", "joke", "serious", "missed the joke", "literal", "taken literally", "subtext", "hint"]) { detectedCategory = .missedCues }
        else if containsAny(input: normalizedInput, triggers: ["oversharing", "talked too much", "waffling", "rambling", "bored them", "info dump", "monologue"]) { detectedCategory = .infoDumping }
        else if containsAny(input: normalizedInput, triggers: ["loud", "bright", "lights", "noise", "too much going on", "overwhelmed", "sensory", "texture", "smell"]) { detectedCategory = .sensoryOverload }
        else if containsAny(input: normalizedInput, triggers: ["replaying", "thinking back", "analyzing", "obsessing", "did i say", "conversation loop"]) { detectedCategory = .rumination }
        else if containsAny(input: normalizedInput, triggers: ["lazy", "procrastinating", "can't start", "late again", "forgot", "lost track", "paralysis"]) { detectedCategory = .executiveDysfunction }
        else if containsAny(input: normalizedInput, triggers: ["interrupting", "cut off", "silence", "awkward pause", "when to speak", "jumped in"]) { detectedCategory = .conversationTiming }
        else if containsAny(input: normalizedInput, triggers: ["too much", "intense", "too loud", "too excited", "calm down", "chill", "annoying"]) { detectedCategory = .intensity }
        else if containsAny(input: normalizedInput, triggers: ["rule", "unwritten", "supposed to do", "weird", "normal", "etiquette", "social norm"]) { detectedCategory = .hiddenRules }
        
        // Fallback
        if detectedCategory == nil {
            detectedCategory = .general
        }
        
        guard let category = detectedCategory else { return nil }
        
        return ContentGenerator.generateLayer1(for: category, input: normalizedInput, passCount: passCount, history: history)
    }
    
    // Transitions: Layer 1 -> Layer 2
    static func processLayer1Selection(optionId: String, currentResponse: AntigravityResponse, passCount: Int = 1, history: Set<String> = []) -> AntigravityResponse? {
        guard let catString = currentResponse.detectedCategory,
              let category = ContextCategory(rawValue: catString) else { return nil }
        
        // Pass optionId to generate deeper context options
        return ContentGenerator.generateLayer2(category: category, previousOptionId: optionId, passCount: passCount, history: history)
    }
    
    // Transitions: Layer 2 -> Layer 3
    static func processLayer2Selection(answerId: String, categoryString: String, passCount: Int = 1, history: Set<String> = []) -> AntigravityResponse? {
        guard let category = ContextCategory(rawValue: categoryString) else { return nil }
        return ContentGenerator.generateLayer3(category: category, previousOptionId: answerId, passCount: passCount, history: history)
    }
    
    // Transitions: Layer 3 -> Final
    static func processLayer3Completion(currentResponse: AntigravityResponse, originalCategory: String?) -> AntigravityResponse? {
        // Retrieve original category to give the specific consolation
        guard let catString = originalCategory ?? currentResponse.detectedCategory,
              let category = ContextCategory(rawValue: catString) else { return nil }
        
        return ContentGenerator.generateFinal(for: category)
    }
    
    private static func containsAny(input: String, triggers: [String]) -> Bool {
        for trigger in triggers {
            if input.contains(trigger) {
                return true
            }
        }
        return false
    }
}
