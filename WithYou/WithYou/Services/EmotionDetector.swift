import Foundation
import SwiftUI

/// The Context Category determined by the Perspective Engine.
enum ContextCategory: String, CaseIterable, Identifiable {
    case conflict = "High Intensity Conflict"
    case exclusion = "Social Exclusion & Absence"
    case digital = "Digital Silence" 
    case tone = "Ambiguous Tone & Vibes"
    case comparison = "Comparison & Inadequacy"
    case socialGuilt = "Perceived Social Error" 
    case futureAnxiety = "Anticipatory Anxiety"
    case unjust = "Unjust Consequences"
    case general = "General Overwhelm" // v5.1 Fallback
    
    // New Categories (Expansion)
    case grief = "Grief & Loss"
    case failure = "Setback & Failure"
    case misunderstood = "Misunderstood & Misinterpreted"
    case accidentalOffense = "Accidental Offense"
    case masking = "Masking & Fitting In"
    case eyeContact = "Eye Contact Anxiety"
    case missedCues = "Missed Social Cues"
    case infoDumping = "Oversharing Interests"
    case sensoryOverload = "Sensory Overload"
    case rumination = "Social Rumination"
    case executiveDysfunction = "Executive Dysfunction"
    case conversationTiming = "Conversation Timing"
    case intensity = "Intensity & Enthusiasm"
    case hiddenRules = "Unwritten Social Rules"
    case panic = "Emergency & Panic"
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .conflict: return "Fights, yelling, or direct aggression."
        case .exclusion: return "Feeling left out, ignored, or rejected."
        case .digital: return "Left on read, dry texts, or ghosting."
        case .tone: return "Sarcasm, weird looks, or confusing jokes."
        case .comparison: return "Feeling behind, failing, or not good enough."
        case .socialGuilt: return "Awkward moments, mistakes, or cringe."
        case .futureAnxiety: return "Scared caused by future events."
        case .unjust: return "Punished despite doing the right thing."
        case .general: return "Feeling stressed, overwhelmed, or confused."
        
        case .grief: return "Processing loss, sadness, and absence."
        case .failure: return "Dealing with setbacks, mistakes, or failed attempts."
        case .misunderstood: return "Feeling like your intent didn't translate."
        case .accidentalOffense: return "Worrying you hurt someone without meaning to."
        case .masking: return "The exhaustion of hiding who you are to fit in."
        case .eyeContact: return "Stress about where to look during conversation."
        case .missedCues: return "Confusion about sarcasm, subtext, or implied meaning."
        case .infoDumping: return "Feeling bad for talking too much about what you love."
        case .sensoryOverload: return "Shutting down because lights/noise/texture is too much."
        case .rumination: return "Replaying conversations to check for errors."
        case .executiveDysfunction: return "Struggling to start, finish, or be on time."
        case .conversationTiming: return "Not knowing when to speak or interrupt."
        case .intensity: return "Being told you are 'too much' or 'too loud'."
        case .hiddenRules: return "Confused by social rules everyone else seems to know."
        case .panic: return "Feeling unsafe, terrified, or out of control."
        }
    }
}

extension ContextCategory {
    var replyText: String {
        switch self {
        case .misunderstood: return "I know that sinking feeling when your words don't match your heart. Take a deep breath. It doesn't make you a bad person. It’s okay to pause and simply say, 'I think that came out wrong, let me try again.' People are often more understanding than our anxiety lets us believe."
        case .accidentalOffense: return "It’s really scary to think you’ve hurt someone, isn't it? But remember, your brain might be amplifying the worst-case scenario. If you're worried, a simple, honest 'Hey, I’m anxious I might have upset you, are we good?' shows how much you care. You don't have to suffer in silence."
        case .masking: return "I hear you, and I’m sorry it’s so heavy right now. Pretending to be someone else is exhausting work. You don't have to be 'on' for everyone. It is perfectly okay to disappear for 10 minutes, go to a quiet room, and just let your face relax. You are allowed to rest."
        case .eyeContact: return "Please be gentle with yourself. Eye contact is just one tiny part of connecting, it’s not the whole picture. If it feels like too much right now, look at their nose or just listen. You are doing your best, and that is enough."
        case .missedCues: return "It’s okay! Social cues can be like a secret code that everyone else seems to have the key to. Missing a joke doesn't mean anything is wrong with you. It’s totally cool to just laugh and say, 'Wait, was that a joke? My brain took that literally!' Real friends won't mind at all."
        case .infoDumping: return "Hey, pause for a second. Your passion is actually a really cool thing about you. It’s not 'annoying,' it’s enthusiasm. If you're worried, just check in with them gently. But please don't dim your light just because you're afraid of taking up space."
        case .sensoryOverload: return "It sounds like the world is turned up too loud right now. That is physically painful, and your reaction is valid. You aren't being difficult; you are protecting your peace. Put on those headphones or step outside. You need to take care of *you* first."
        case .rumination: return "I know that replay button is stuck in your head, but I promise you: nobody else is analyzing that moment like you are. Everyone is too busy worrying about themselves! Be kind to yourself. You're human, and humans are awkward sometimes. It really is okay."
        case .executiveDysfunction: return "You are not lazy. You are battling a brain that works differently, and that is hard work. Forgive yourself for the slip-up. It happens. Just set a new alarm for next time and move forward. You care, and that is what counts."
        case .conversationTiming: return "Conversations are like double-dutch—it's honestly hard to jump in! It’s okay if the rhythm felt off today. If you accidentally interrupt, a quick 'Sorry, I got excited, go ahead' smooths it over instantly. You have valuable things to say, don't give up on saying them."
        case .intensity: return "Deep breaths. You have a big heart and big feelings, and that is a gift, not a flaw. Maybe this wasn't the right room for that energy, and that's okay. There are people out there who will love your intensity. Don't shrink yourself."
        case .hiddenRules: return "It is scary walking into the unknown without a map. But guess what? Most people are winging it too. It is perfectly okay to stand back and watch for a bit before you join in. You don't have to perform immediately. Take your time."
        
        // Default / Existing Categories Mapped to Empathetic Conversational Responses
        case .panic: return "Look at you. You did it. I know that felt like a storm that would never end, but you rode the wave and made it to the shore. I am so, so proud of you. Please be gentle with yourself for the rest of the day—fighting off panic is like running a marathon. Drink a sip of water, shake out your shoulders, and take a moment to just exist. You are safe, and you are back."
            
        case .grief: return "Grief has no timeline. It comes in waves, and tonight's wave is just particularly high. You don't have to 'fix' this feeling. Just let it wash over you. You are safe, and this pain is a testament to how much you loved."
        case .failure: return "This specific outcome does not define your worth. Failure is just data, not a character flaw. It stings now, but it is teaching you something valuable for next time. Breathe. You are still you."
        case .conflict: return "Conflict creates adrenaline, and your body is still processing that spike. It makes sense that you feel this way. Step away from the situation mentally for a moment. You are safe here."
        
        default: return "This feeling is temporary, even if it feels permanent right now. You are doing the hard work of reflecting, and that is brave. Be kind to yourself tonight."
        }
    }
}

/// Analyzes keywords and generates the full content for the Antigravity Flow.
struct ContentGenerator {
    
    // MARK: - Layer 1: Meaning Clarification (The "What")
    static func generateLayer1(for category: ContextCategory, input: String, passCount: Int, history: Set<String>) -> AntigravityResponse {
        let options = getPhase1Options(for: category, input: input, passCount: passCount)
        
        // If it's Pass 2, slightly adjust the question to acknowledge depth
        let question = (passCount > 1) ? "Let's look a little deeper. What else resonates?" : "Choose what resonates most:"
        
        return AntigravityResponse(
            phase: 1,
            hapticFeedback: "medium",
            empathyHeader: category.empathyHeader,
            detectedCategory: category.rawValue,
            validationText: "Let's pause. What felt most important about this?",
            questionText: question,
            actionCardTitle: nil,
            actionCardBody: nil,
            summaryText: nil,
            dailyAnchor: nil,
            closingMessage: nil,
            nextTimeTips: nil,
            options: options
        )
    }
    
    // MARK: - Layer 2: Context Framing (The "Where/How")
    static func generateLayer2(category: ContextCategory, previousOptionId: String?, passCount: Int, history: Set<String>) -> AntigravityResponse {
        let options = getPhase2Options(for: category, previousOptionId: previousOptionId, passCount: passCount)
        
        // Pass 2 Framing
        let validation = (passCount > 1) ? "There is always more to the story." : "Context changes everything."
        
        return AntigravityResponse(
            phase: 2,
            hapticFeedback: "light",
            empathyHeader: nil,
            detectedCategory: nil,
            validationText: validation,
            questionText: "What else was influencing this moment?",
            actionCardTitle: nil,
            actionCardBody: nil,
            summaryText: nil,
            dailyAnchor: nil,
            closingMessage: nil,
            nextTimeTips: nil,
            options: options
        )
    }
    
    // MARK: - Layer 3: Emotional Impact (The "Feel")
    static func generateLayer3(category: ContextCategory, previousOptionId: String?, passCount: Int, history: Set<String>) -> AntigravityResponse {
        let options = getPhase3Options(for: category, previousOptionId: previousOptionId, passCount: passCount)
        
        let validation = (passCount > 1) ? "It's safe to feel the nuance." : "It helps to name the feeling effectively."
        
        return AntigravityResponse(
            phase: 3,
            hapticFeedback: "medium",
            empathyHeader: nil,
            detectedCategory: nil,
            validationText: validation,
            questionText: "Which of these feels closest to your truth?",
            actionCardTitle: nil,
            actionCardBody: nil,
            summaryText: nil,
            dailyAnchor: nil,
            closingMessage: nil,
            nextTimeTips: nil,
            options: options
        )
    }
    
    // MARK: - Final: Consolation & Support
    static func generateFinal(for category: ContextCategory) -> AntigravityResponse {
        return AntigravityResponse(
            phase: 4,
            hapticFeedback: "success",
            empathyHeader: nil,
            detectedCategory: nil,
            validationText: nil,
            questionText: nil,
            actionCardTitle: "Core Reflection",
            actionCardBody: category.replyText,
            summaryText: "You have walked through this with courage.",
            dailyAnchor: category.dailyAnchor,
            closingMessage: "You are safe, and you are doing your best.",
            nextTimeTips: category.tips,
            options: nil
        )
    }
    
    // MARK: - Emergency Mode
    static func generateEmergency() -> AntigravityResponse {
        return AntigravityResponse(
            phase: 0, // Special Emergency Phase
            hapticFeedback: "heavy",
            empathyHeader: "EMERGENCY: PANIC DETECTED",
            detectedCategory: ContextCategory.panic.rawValue,
            validationText: "I’ve got you. I know this feels absolutely terrifying right now, but I need you to trust me: You are safe. You are not dying. Your body is just pulling a false alarm. I’m right here.",
            questionText: nil,
            actionCardTitle: "Grounding",
            actionCardBody: "Don't try to force a deep breath yet. Just exhale. Blow all the air out of your lungs until they are empty. Now, look at your feet. Wiggle your toes. Feel the ground underneath you. You are here. This wave is going to pass, I promise.",
            summaryText: nil,
            dailyAnchor: nil,
            closingMessage: nil,
            nextTimeTips: nil,
            options: [
                AntigravityOption(id: "better", icon: "checkmark.circle.fill", title: "I'm feeling calmer", subtitle: "The wave is passing."),
                AntigravityOption(id: "still_bad", icon: "exclamationmark.circle.fill", title: "Still struggling", subtitle: "I need to breathe again.")
            ]
        )
    }
    
    // MARK: - Deprecated Phase 2/3 Wrappers
    // (Removed during V5.0 Deepening Refactor)
    // The logic is now inside generateLayer2 and generateLayer3

    

    // MARK: - Helpers
    
    // Layer 1 Options: Meaning Clarification (5+ options, Input Sensitive)
    private static func getPhase1Options(for category: ContextCategory, input: String, passCount: Int) -> [AntigravityOption] {
        let text = input.lowercased()
        
        // Pass 2 Variants
        if passCount > 1 {
            switch category {
            case .tone, .missedCues, .misunderstood:
                return [
                    AntigravityOption(id: "p2_tone_subtle", icon: "waveform", title: "Subtle Shift", subtitle: "Was it a tiny change in voice?"),
                    AntigravityOption(id: "p2_tone_context", icon: "person.2", title: "Audience", subtitle: "Did they change because others were there?"),
                    AntigravityOption(id: "p2_tone_tired", icon: "battery.25", title: "Exhaustion", subtitle: "Did they sound drained?"),
                    AntigravityOption(id: "p2_tone_project", icon: "mirror.side.left", title: "Projection", subtitle: "Was I expecting the worst?"),
                    AntigravityOption(id: "p2_tone_cultural", icon: "globe", title: "Cultural Diff", subtitle: "Is this just how they speak?")
                ]
            case .digital, .exclusion:
                return [
                     AntigravityOption(id: "p2_dig_overthink", icon: "brain", title: "Overthinking", subtitle: "Am I filling in the blanks?"),
                     AntigravityOption(id: "p2_dig_priorities", icon: "list.number", title: "Priorities", subtitle: "Do they have a crisis right now?"),
                     AntigravityOption(id: "p2_dig_tech", icon: "iphone.slash", title: "Digital Fatige", subtitle: "Are they bad at texting?"),
                     AntigravityOption(id: "p2_dig_drift", icon: "wind", title: "Drifting", subtitle: "Are we just growing apart?"),
                     AntigravityOption(id: "p2_dig_social", icon: "person.3.slash", title: "Social Capacity", subtitle: "Are they hiding from everyone?")
                ]
            case .conflict, .unjust, .accidentalOffense:
                 return [
                    AntigravityOption(id: "p2_con_values", icon: "shield.check", title: "Values Clash", subtitle: "Is this about something deeper?"),
                    AntigravityOption(id: "p2_con_stress", icon: "bolt.heart", title: "Stress Spillover", subtitle: "Was the anger about me?"),
                    AntigravityOption(id: "p2_con_regret", icon: "arrow.uturn.backward", title: "Their Regret", subtitle: "Do they look like they regret it?"),
                    AntigravityOption(id: "p2_con_control", icon: "hand.raised", title: "Loss of Control", subtitle: "Did they just snap?"),
                    AntigravityOption(id: "p2_con_communicate", icon: "bubble.left.slash", title: "Communication Gap", subtitle: "Are we speaking different languages?")
                 ]
            default:
                 return [
                     AntigravityOption(id: "p2_gen_detail", icon: "magnifyingglass", title: "The Details", subtitle: "Small things added up."),
                     AntigravityOption(id: "p2_gen_mood", icon: "cloud.fog", title: "The Mood", subtitle: "The vibe was off."),
                     AntigravityOption(id: "p2_gen_past", icon: "clock.arrow.circlepath", title: "Past Echoes", subtitle: "This reminds me of before."),
                     AntigravityOption(id: "p2_gen_control", icon: "dial", title: "Control", subtitle: "I felt helpless."),
                     AntigravityOption(id: "p2_gen_focus", icon: "viewfinder", title: "Focus", subtitle: "I was hyper-focused.")
                 ]
            }
        }
        
        // Pass 1 (Standard)
        switch category {
        case .tone, .missedCues, .misunderstood:
            var opts = [
                 AntigravityOption(id: "tone_flat", icon: "waveform.path.ecg", title: "Flat Tone", subtitle: "Did it feel weirdly emotionless?"),
                 AntigravityOption(id: "tone_mismatch", icon: "face.dashed", title: "Mismatch", subtitle: "Did valid words sound mean?"),
                 AntigravityOption(id: "tone_joke", icon: "mouth", title: "Hidden Joke", subtitle: "Could it have been playful?"),
                 AntigravityOption(id: "tone_unexpected", icon: "exclamationmark.bubble", title: "Unexpected", subtitle: "Did it contradict their usual vibe?"),
                 AntigravityOption(id: "tone_unclear", icon: "questionmark.diamond", title: "Unclear Meaning", subtitle: "Did you just feel confused?"),
            ]
            if text.contains("sarcasm") || text.contains("joke") {
                 opts.insert(AntigravityOption(id: "tone_sarcasm", icon: "quote.bubble", title: "Sarcasm", subtitle: "Was it exaggerated or dry?"), at: 0)
            }
            return opts
            
        case .digital, .exclusion:
            var opts = [
                 AntigravityOption(id: "dig_pattern", icon: "clock.arrow.circlepath", title: "Pattern", subtitle: "Is this silence typical for them?"),
                 AntigravityOption(id: "dig_abrupt", icon: "slash.circle", title: "Abrupt End", subtitle: "Did the chat stop suddenly?"),
                 AntigravityOption(id: "dig_construct", icon: "bubble.left.and.bubble.right", title: "Expectation", subtitle: "Did you expect a reply?"),
                 AntigravityOption(id: "dig_unfinished", icon: "ellipsis.bubble", title: "Unfinished", subtitle: "Did it feel unresolved?"),
                 AntigravityOption(id: "dig_busy", icon: "car.fill", title: "Context", subtitle: "Could they just be busy?"),
            ]
            if text.contains("ghost") {
                 opts.insert(AntigravityOption(id: "dig_ghost", icon: "ghost", title: "Ghosting", subtitle: "Did they disappear completely?"), at: 0)
            }
            return opts

        case .conflict, .unjust, .accidentalOffense:
            return [
                 AntigravityOption(id: "con_escalate", icon: "flame.fill", title: "Sudden Escalation", subtitle: "Did it blow up quickly?"),
                 AntigravityOption(id: "con_personal", icon: "person.fill.xmark", title: "Personal Attack", subtitle: "Did it feel like an attack on you?"),
                 AntigravityOption(id: "con_unresolved", icon: "lock.fill", title: "Blockage", subtitle: "Does it feel stuck?"),
                 AntigravityOption(id: "con_tone", icon: "speaker.wave.3.fill", title: "Tone Shift", subtitle: "Did their voice change?"),
                 AntigravityOption(id: "con_dismissed", icon: "hand.raised.slash", title: "Dismissal", subtitle: "Did you feel unheard?")
            ]

        case .comparison, .failure, .socialGuilt, .futureAnxiety:
             return [
                 AntigravityOption(id: "self_question", icon: "questionmark.circle", title: "Self-Doubt", subtitle: "Did this make you question yourself?"),
                 AntigravityOption(id: "self_trigger", icon: "bolt.horizontal", title: "External Trigger", subtitle: "Did seeing someone else start this?"),
                 AntigravityOption(id: "self_expect", icon: "chart.bar.doc.horizontal", title: "Unclear Rules", subtitle: "Were expectations vague?"),
                 AntigravityOption(id: "self_public", icon: "person.3.fill", title: "Public Eye", subtitle: "Did this happen in front of others?"),
                 AntigravityOption(id: "self_history", icon: "clock.arrow.circlepath", title: "History", subtitle: "Does this connect to the past?")
             ]
            
        default:
             // Generic Fallback with 5 options
             return [
                 AntigravityOption(id: "gen_intent", icon: "heart", title: "My Intent", subtitle: "I meant well."),
                 AntigravityOption(id: "gen_impact", icon: "arrow.right.circle", title: "The Impact", subtitle: "It landed wrong."),
                 AntigravityOption(id: "gen_energy", icon: "battery.25", title: "My Energy", subtitle: "I was already drained."),
                 AntigravityOption(id: "gen_environment", icon: "cloud.sun", title: "The Situation", subtitle: "It was a bad time."),
                 AntigravityOption(id: "gen_unknown", icon: "questionmark", title: "The Unknown", subtitle: "I just don't know.")
             ]
        }
    }
    
    // Layer 2 Options: Context Framing (5+ options, Dependent on Previous Choice)
    private static func getPhase2Options(for category: ContextCategory, previousOptionId: String?, passCount: Int) -> [AntigravityOption] {
        
        if passCount > 1 {
            // Pass 2 Context Options
             return [
                AntigravityOption(id: "p2_ctx_bio", icon: "heart.text.square", title: "Biology", subtitle: "Hunger, Pain, Hormones?"),
                AntigravityOption(id: "p2_ctx_sys", icon: "gearshape.2", title: "Systems", subtitle: "Broken processes?"),
                AntigravityOption(id: "p2_ctx_env", icon: "house", title: "Environment", subtitle: "Unsafe space?"),
                AntigravityOption(id: "p2_ctx_info", icon: "info.circle", title: "Information", subtitle: "Missing key facts?"),
                AntigravityOption(id: "p2_ctx_expt", icon: "person.crop.circle.badge.exclamationmark", title: "Expectations", subtitle: "Unspoken rules?")
             ]
        }
        
        switch category {
        case .tone, .missedCues, .misunderstood:
             return [
                AntigravityOption(id: "ctx_stress", icon: "briefcase.fill", title: "External Stress", subtitle: "Could they be stressed at work/school?"),
                AntigravityOption(id: "ctx_tired", icon: "bed.double.fill", title: "Fatigue", subtitle: "Were they (or you) just tired?"),
                AntigravityOption(id: "ctx_history", icon: "clock.fill", title: "History", subtitle: "Do you have a rocky past?"),
                AntigravityOption(id: "ctx_medium", icon: "iphone", title: "The Medium", subtitle: "Was this over text/chat?"),
                AntigravityOption(id: "ctx_sensory", icon: "speaker.wave.3", title: "Noise", subtitle: "Was it loud or chaotic?")
             ]
            
        case .digital, .exclusion:
             return [
                AntigravityOption(id: "ctx_busy", icon: "calendar", title: "Busy Schedule", subtitle: "Are they swamped right now?"),
                AntigravityOption(id: "ctx_forget", icon: "brain.head.profile", title: "Forgetfulness", subtitle: "Are they prone to forgetting?"),
                AntigravityOption(id: "ctx_group", icon: "person.3", title: "Group Dynamics", subtitle: "Was this a group decision?"),
                AntigravityOption(id: "ctx_tech", icon: "wifi.slash", title: "Tech Issues", subtitle: "Could it be a missed notification?"),
                AntigravityOption(id: "ctx_energy", icon: "battery.0", title: "Low Battery", subtitle: "Is everyone just drained?")
             ]
            
        case .conflict, .unjust, .accidentalOffense:
             return [
                AntigravityOption(id: "ctx_miscom", icon: "bubble.left.and.bubble.right.fill", title: "Miscommunication", subtitle: "Did wires just get crossed?"),
                AntigravityOption(id: "ctx_trigger", icon: "bolt.fill", title: "Trigger Stack", subtitle: "Was this the last straw?"),
                AntigravityOption(id: "ctx_power", icon: "arrow.up.and.down", title: "Power Dynamic", subtitle: "Is there an authority issue?"),
                AntigravityOption(id: "ctx_values", icon: "shield.fill", title: "Values", subtitle: "Are core values clashing?"),
                AntigravityOption(id: "ctx_timing", icon: "hourglass", title: "Bad Timing", subtitle: "Was it just the wrong moment?")
             ]
            
        default:
             return [
                AntigravityOption(id: "ctx_phys", icon: "heart.fill", title: "Physical Needs", subtitle: "Hungry, tired, or in pain?"),
                AntigravityOption(id: "ctx_env", icon: "sun.max", title: "Environment", subtitle: "Too bright, loud, or hot?"),
                AntigravityOption(id: "ctx_soc", icon: "person.2", title: "Social Battery", subtitle: "Were you peopled-out?"),
                AntigravityOption(id: "ctx_info", icon: "book.closed", title: "Missing Info", subtitle: "Do you have all the facts?"),
                AntigravityOption(id: "ctx_time", icon: "calendar.badge.clock", title: "Time Pressure", subtitle: "Were you rushing?")
             ]
        }
    }
    
    // Layer 3 Options: Emotional Impact (5+ options, Specific Feelings)
    private static func getPhase3Options(for category: ContextCategory, previousOptionId: String?, passCount: Int) -> [AntigravityOption] {
        
        if passCount > 1 {
             return [
                AntigravityOption(id: "p2_emo_complex", icon: "scribble", title: "Complex", subtitle: "Mixed emotions."),
                AntigravityOption(id: "p2_emo_relieved", icon: "sun.min", title: "Relief", subtitle: "Glad it's done."),
                AntigravityOption(id: "p2_emo_tired", icon: "bed.double", title: "Weary", subtitle: "Bone deep tired."),
                AntigravityOption(id: "p2_emo_resilient", icon: "figure.walk", title: "Resilient", subtitle: "I can handle this."),
                AntigravityOption(id: "p2_emo_curious", icon: "magnifyingglass", title: "Curious", subtitle: "Wondering why.")
             ]
        }
        
        switch category {
        case .conflict, .unjust, .accidentalOffense:
             return [
                AntigravityOption(id: "emo_unfair", icon: "hand.raised.fill", title: "Injustice", subtitle: "It feels absolutely unfair."),
                AntigravityOption(id: "emo_scared", icon: "exclamationmark.shield.fill", title: "Unsafe", subtitle: "I feel shaken and unsafe."),
                AntigravityOption(id: "emo_guilt", icon: "person.fill.xmark", title: "Guilt", subtitle: "I feel like I messed up."),
                AntigravityOption(id: "emo_angry", icon: "flame.circle.fill", title: "Anger", subtitle: "I am burning with anger."),
                AntigravityOption(id: "emo_numb", icon: "cloud.fill", title: "Numbness", subtitle: "I just feel shut down.")
             ]
            
        case .digital, .exclusion, .missedCues:
             return [
                AntigravityOption(id: "emo_lonely", icon: "person.slash.fill", title: "Lonely", subtitle: "I feel isolated."),
                AntigravityOption(id: "emo_stupid", icon: "brain.head.profile", title: "Foolish", subtitle: "I feel like I should have known."),
                AntigravityOption(id: "emo_anxious", icon: "waveform.path.ecg", title: "Anxious", subtitle: "I'm waiting for the other shoe to drop."),
                AntigravityOption(id: "emo_sad", icon: "cloud.rain.fill", title: "Sadness", subtitle: "It hurts my heart."),
                AntigravityOption(id: "emo_confused", icon: "questionmark.circle", title: "Confusion", subtitle: "I just don't understand.")
             ]
            
        default:
             return [
                AntigravityOption(id: "emo_overwhelmed", icon: "tornado", title: "Overwhelmed", subtitle: "It's all too much."),
                AntigravityOption(id: "emo_dread", icon: "calendar.badge.exclamationmark", title: "Dread", subtitle: "I don't want to face it."),
                AntigravityOption(id: "emo_shame", icon: "eye.slash", title: "Shame", subtitle: "I want to disappear."),
                AntigravityOption(id: "emo_hope", icon: "sunrise.fill", title: "Hopeful", subtitle: "I think it will be okay."),
                AntigravityOption(id: "emo_neutral", icon: "circle", title: "Neutral", subtitle: "I'm just observing.")
             ]
        }
    }
    
    private static func getValidation(for category: ContextCategory, optionId: String) -> String {
        // Validation logic - simplified for demo, could be specific per Option ID
        switch category {
        case .conflict: return "Aggression feels personal, but it is almost always a sign of the other person's internal chaos, not your worth."
        case .exclusion: return "Being left out triggers ancient survival fears. It makes sense that your brain is sounding an alarm."
        case .digital: return "Waiting for a reply creates a vacuum, and our anxious brains fill that vacuum with the worst case scenarios."
        case .tone: return "Ambiguity is the playground of anxiety. Without clear data, your brain assumes safety is threatened."
        case .comparison: return "Comparison is a natural human instinct, but in the digital age, we are flooded with distorted data."
        case .socialGuilt: return "We replay our mistakes to learn from them, but sometimes the replay button gets stuck. You are not your mistake."
        case .futureAnxiety: return "Your brain is trying to protect you by predicting danger. It's doing its job, but it's searching too hard."
        case .unjust: return "It is profoundly painful when the world breaks its own rules. Your frustration is a healthy response to injustice."
        case .general: return "Sometimes there isn't a specific 'why' - just a heavy feeling. Your nervous system is signaling that it needs care, and that is valid."
        
        case .grief: return "Loss creates a hole in the world. It is okay to sit by the edge of that hole and just dangle your feet for a while. You don't have to fix it."
        case .failure: return "Failure is not a verdict; it's just data. It tells you what didn't work, which is the first step to finding what does. You have so much potential."
        case .misunderstood: return "The gap between what we mean and what others hear is painful. But your true intent remains real, even if they can't see it yet."
        case .accidentalOffense: return "Good people make mistakes. The fact that you care about the impact shows your heart is in the right place."
        case .masking: return "Hiding who you are is the heaviest weight to carry. It makes sense that you are exhausted. You deserve a place to just be."
        case .eyeContact: return "Eye contact is just one channel of connection. You can listen deeply and care profoundly without staring into someone's soul."
        case .missedCues: return "Human communication is full of invisible tripwires. Missing one doesn't mean you're broken; it means the system is obscure."
        case .infoDumping: return "Your brain lights up with joy when you share what you love. That enthusiasm is beautiful, even if the world isn't always ready for the voltage."
        case .sensoryOverload: return "When the world is too loud or bright, shutting down is not rude—it's survival. Your brain is trying to keep you safe."
        case .rumination: return "Analyzing the past gives us the illusion of control. But that conversation is over. You can put the microscope down now."
        case .executiveDysfunction: return "In a world built for linear schedules, your brain works in waves. That isn't laziness; it's a different operating system."
        case .conversationTiming: return "Conversation is a double-Dutch jump rope game. It's tricky to find the rhythm, but missing a jump doesn't mean you can't play."
        case .intensity: return "Are you 'too much'? Or is the container just too small? Your intensity is just your capacity to feel and care deeply."
        case .hiddenRules: return "Society runs on a script that nobody bothered to write down. It is frustrating to play a game when no one told you the rules."
        case .panic: return "Your body is sounding a false alarm. You are safe. The danger is not real, even though the feeling is."
        }
    }
}

extension ContextCategory {
    var empathyHeader: String {
        switch self {
        case .conflict: return "It sounds like you dealt with some intense energy."
        case .exclusion: return "Feeling left out is a heavy, lonely feeling."
        case .digital: return "The silence can feel really loud and confusing."
        case .tone: return "It's unsettling when you can't read the room."
        case .comparison: return "It’s hard when it feels like everyone else is ahead."
        case .socialGuilt: return "That 'cringe' feeling is really uncomfortable."
        case .futureAnxiety: return "The unknown is a scary place to be."
        case .unjust: return "It hurts when you do everything right and still lose."
        case .general: return "It sounds like you are carrying a lot right now."
        
        case .grief: return "I am so sorry. I’m here with you."
        case .failure: return "It’s hard when things don't go as planned."
        case .misunderstood: return "It is frustrating when your true self isn't seen."
        case .accidentalOffense: return "It feels awful to think you caused harm."
        case .masking: return "It is exhausting to perform all day."
        case .eyeContact: return "It’s okay. Eye contact is intense."
        case .missedCues: return "Social signals can be incredibly confusing."
        case .infoDumping: return "Your passion is a gift, not a burden."
        case .sensoryOverload: return "Your system is protecting you from too much input."
        case .rumination: return "The replay button in your mind is stuck."
        case .executiveDysfunction: return "You are not lazy. You are trying."
        case .conversationTiming: return "The rhythm of conversation is hard to catch."
        case .intensity: return "Your energy is a powerful force."
        case .hiddenRules: return "It feels like everyone else got a manual you didn’t."
        case .panic: return "I know it feels like the walls are closing in."
        }
    }
    
    var dailyAnchor: String {
        switch self {
        case .conflict: return "I am safe, even when others are stormy."
        case .exclusion: return "I am whole, with or without this invitation."
        case .digital: return "My worth is not determined by a response time."
        case .tone: return "Create your own clarity."
        case .comparison: return "My timeline is mine alone."
        case .socialGuilt: return "I am allowed to be perfectly imperfect."
        case .futureAnxiety: return "I handle what comes, one breath at a time."
        case .unjust: return "My integrity is my victory."
        case .general: return "I am enough, just as I am right now."
        
        case .grief: return "I allow myself to feel this loss."
        case .failure: return "I am learning, growing, and becoming."
        case .misunderstood: return "I know my own heart."
        case .accidentalOffense: return "I can repair mistakes with kindness."
        case .masking: return "My authentic self is worthy of love."
        case .eyeContact: return "I listen with my ears and my mind, not just my eyes."
        case .missedCues: return "I can ask for clarity."
        case .infoDumping: return "My joy is valid."
        case .sensoryOverload: return "I am allowed to step back and breathe."
        case .rumination: return "That moment is over. I am here now."
        case .executiveDysfunction: return "Small steps are still steps."
        case .conversationTiming: return "My voice deserves to be heard."
        case .intensity: return "I embrace my vibrant spirit."
        case .hiddenRules: return "I define my own way of being."
        case .panic: return "I am safe. This will pass."
        }
    }
    
    var tips: [Tip] {
        switch self {
        case .conflict: return [
            Tip(icon: "clock.badge.exclamationmark", text: "24-Hour Rule: Wait before replying."),
            Tip(icon: "person.wave.2.fill", text: "Physical Space: Step away."),
            Tip(icon: "mouth", text: "Use 'I feel' statements.")
        ]
        case .exclusion: return [
            Tip(icon: "speaker.slash.fill", text: "Mute stories for 24h."),
            Tip(icon: "person.2.fill", text: "Reach out to a safe friend."),
            Tip(icon: "paintpalette.fill", text: "Do a solo hobby.")
        ]
        case .digital: return [
            Tip(icon: "iphone.slash", text: "Put phone in another room."),
            Tip(icon: "gamecontroller.fill", text: "Play a game to distract."),
            Tip(icon: "xmark.circle", text: "Assume positive intent.")
        ]
        case .tone: return [
            Tip(icon: "questionmark.bubble", text: "Ask: 'Everything okay?'"),
            Tip(icon: "ear.and.waveform", text: "Listen to music."),
            Tip(icon: "eye.slash", text: "Don't mind-read.")
        ]
        case .comparison: return [
            Tip(icon: "arrow.down.right.circle", text: "Compare Down: Look how far you've come."),
            Tip(icon: "hand.raised.slash", text: "Limit scrolling."),
            Tip(icon: "star.fill", text: "List 3 strengths.")
        ]
        case .socialGuilt: return [
            Tip(icon: "person.fill.turn.down", text: "Spotlight Check: They forgot."),
            Tip(icon: "arrow.uturn.forward", text: "It was just practice."),
            Tip(icon: "heart.fill", text: "Forgive yourself.")
        ]
        case .futureAnxiety: return [
            Tip(icon: "pencil.and.outline", text: "Write the worst case. Solve it."),
            Tip(icon: "figure.walk", text: "Move your body."),
            Tip(icon: "checkmark.circle", text: "Trust your past work.")
        ]
        case .unjust: return [
            Tip(icon: "doc.text", text: "Document your efforts."),
            Tip(icon: "scissors", text: "Separate Process from Outcome."),
            Tip(icon: "timer", text: "Vent for 10 mins, then stop.")
        ]
        case .general: return [
            Tip(icon: "bed.double.fill", text: "Rest your eyes for 5 mins."),
            Tip(icon: "drop.fill", text: "Drink a glass of water."),
            Tip(icon: "heart.fill", text: "Be gentle with yourself.")
        ]
        
        case .grief: return [
            Tip(icon: "cup.and.saucer.fill", text: "Drink warm tea."),
            Tip(icon: "heart.fill", text: "Hand on heart."),
            Tip(icon: "moon.fill", text: "Rest. No fixing needed.")
        ]
        case .failure: return [
            Tip(icon: "arrow.up.circle.fill", text: "You got this."),
            Tip(icon: "star.fill", text: "You have potential."),
            Tip(icon: "clock.arrow.circlepath", text: "Next time will be better.")
        ]
        case .misunderstood: return [
            Tip(icon: "bubble.left.and.bubble.right.fill", text: "State Intent Explicitly: 'My intent is to be helpful, not critical.'"),
            Tip(icon: "ear.and.waveform", text: "The Echo Method: Ask 'Does that make sense?' to correct discrepancies."),
            Tip(icon: "person.fill.checkmark", text: "Validate yourself first.")
        ]
        case .accidentalOffense: return [
            Tip(icon: "lock.shield", text: "Safe Word: Ask friends to tell you gently if you cross a line."),
            Tip(icon: "questionmark.circle", text: "The Check-In: Ask 'Did what I just said land okay?'"),
            Tip(icon: "heart.circle", text: "Repair > Regret.")
        ]
        case .masking: return [
            Tip(icon: "timer", text: "Unmasking Breaks: 10 mins every hour to stim or relax."),
            Tip(icon: "switch.2", text: "Selective Masking: Save it for interviews, drop it with friends."),
            Tip(icon: "house.fill", text: "Home is safe.")
        ]
        case .eyeContact: return [
            Tip(icon: "triangle", text: "The Triangle Trick: Look at their nose/between eyebrows."),
            Tip(icon: "mouth", text: "Verbal Disclaimer: 'I listen better when I didn't look directly at you.'"),
            Tip(icon: "eye.slash", text: "Reduce pressure.")
        ]
        case .missedCues: return [
            Tip(icon: "questionmark.bubble", text: "Ask for Clarification: 'Was that sarcasm?'"),
            Tip(icon: "chart.bar", text: "Wait for Baseline: Compare their joke tone to their neutral tone."),
            Tip(icon: "person.2", text: "Honesty connects.")
        ]
        case .infoDumping: return [
            Tip(icon: "traffic.light", text: "Traffic Light Check: Green (Asking) vs Red (Looking away)."),
            Tip(icon: "arrow.turn.up.right", text: "Permission to Pivot: 'Feel free to stop me if I go on too long.'"),
            Tip(icon: "star.fill", text: "Your passion is valid.")
        ]
        case .sensoryOverload: return [
            Tip(icon: "mouth", text: "Pre-emptive Explanation: 'The lights give me a headache, I might be quiet.'"),
            Tip(icon: "sunglasses.fill", text: "Sensory Tools: Use loops or tinted glasses."),
            Tip(icon: "figure.walk", text: "Step out.")
        ]
        case .rumination: return [
            Tip(icon: "clock.arrow.circlepath", text: "24-Hour Rule: If no angry text in 24h, assume fine."),
            Tip(icon: "doc.text.magnifyingglass", text: "Fact-Check: Do I have evidence or just anxiety?"),
            Tip(icon: "stop.circle", text: "Stop the tape.")
        ]
        case .executiveDysfunction: return [
            Tip(icon: "calendar", text: "Externalize Memory: Don't trust your brain, use alarms immediately."),
            Tip(icon: "bubble.left", text: "Communicate: 'I struggle with time blindness.'"),
            Tip(icon: "checkmark.circle", text: "Small steps count.")
        ]
        case .conversationTiming: return [
            Tip(icon: "hand.raised.fill", text: "Physical Cues: Raise hand slightly or lean forward."),
            Tip(icon: "lungs", text: "The Breath Gap: Jump in when they inhale."),
            Tip(icon: "eye", text: "Watch for the pause.")
        ]
        case .intensity: return [
            Tip(icon: "person.3.fill", text: "Find Your Tribe: Communities where passion is the norm."),
            Tip(icon: "5.circle", text: "Grounding: 5-4-3-2-1 technique if energy spikes."),
            Tip(icon: "bolt.fill", text: "Channel it.")
        ]
        case .hiddenRules: return [
            Tip(icon: "person.fill.questionmark", text: "Cultural Interpreter: Ask 'What is the rule here?'"),
            Tip(icon: "eye", text: "Observe First: Watch for 10 mins before engaging."),
            Tip(icon: "book.closed", text: "Learn the game.")
        ]
        case .panic: return [
            Tip(icon: "lungs.fill", text: "Focus on Exhaling."),
            Tip(icon: "drop.fill", text: "Cold water on wrists."),
            Tip(icon: "figure.walk", text: "Feel your feet on the floor.")
        ]
        }
    }
}
