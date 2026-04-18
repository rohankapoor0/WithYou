# WithYou 🌊

**WithYou** is a modern, AI-powered emotional reflection and journaling application designed to help you navigate complex feelings with empathy and clarity. Built with a focus on neurodivergent-friendly features and a "liquid glass" aesthetic, it provides a safe space to process everything from digital silence to sensory overload.

---

## ✨ Features

### 🧠 The Perspective Engine
Our core AI engine doesn't just "detect mood"—it understands context. It recognizes **30+ unique emotional categories**, including:
- **Neurodivergent Specifics**: Masking, Info-dumping, Sensory Overload, Executive Dysfunction, and Social Rumination.
- **Modern Social Challenges**: Digital Silence (ghosting/seen), Tone Ambiguity, and Perception Errors.
- **Core Life Events**: Grief, Conflict, Comparison, and Unjust Consequences.

### 🛡️ Emergency Mode (Panic Support)
Detected through real-time input analysis, the app instantly switches to a high-priority "Grounding" mode when it senses panic, providing immediate breathing exercises and tactical grounding steps.

### 🔄 Multi-Layer Reflection
Walk through a guided reflection process designed to de-escalate anxiety:
1. **Layer 1: Meaning**: Clarifying what happened.
2. **Layer 2: Context**: Framing the external factors.
3. **Layer 3: Emotional Impact**: Naming the feeling precisely.
4. **Final: Validated Response**: Receiving an AI-generated, empathetic consolation and actionable "Daily Anchor."

### 📖 Journaling with Heart
- **SwiftUI & Core Data**: Fast, secure, and private local storage.
- **Emotional Tagging**: Link your reflections directly to your journal entries.
- **Glassmorphism UI**: A stunning, airy design system using liquid gradients and blurred materials.

---

## 🛠️ Tech Stack

- **UI Framework**: SwiftUI
- **Persistence**: Core Data
- **AI Backend**: Google Gemini AI
- **Design System**: Vanilla CSS-inspired Swift Theme with Liquid Glass components.

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- A Google Gemini API Key

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/rohankapoor0/WithYou.git
   cd WithYou
   ```

2. **Configure API Keys**:
   The project uses `.xcconfig` files to keep secrets safe.
   - Locate `WithYou/Secrets.template.xcconfig`.
   - Duplicate it and rename the copy to `Secrets.xcconfig`.
   - Open `Secrets.xcconfig` and paste your Gemini API Key:
     ```bash
     GEMINI_API_KEY = your_key_here
     ```

3. **Build & Run**:
   Open `WithYou.xcodeproj` in Xcode and hit `Cmd + R`.

---

## 🎨 Aesthetic Design
The app uses a custom **Liquid Glass** theme:
- **Colors**: Sky Blue & Soft Teal gradients.
- **Materials**: Ultra-thin materials with soft cyan glows.
- **Accessibility**: Support for Dynamic Type and high-contrast dark mode.

---

## 🔒 Privacy & Safety
WithYou is designed with privacy first. Your journal entries are stored locally on your device via Core Data. AI reflections are processed securely via the Gemini API, and no personal identifiable information is tracked beyond what you provide for analysis.

---

## 📄 License
This project is for personal reflection and growth. [Specify License if applicable].

---
*Created with ❤️ by Rohan Kapoor*