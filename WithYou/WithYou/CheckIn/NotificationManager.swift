import Foundation
import Combine
@preconcurrency import UserNotifications
import SwiftUI

/// Manages the daily, gentle check-in notification.
/// All scheduling is local-only on device.
@MainActor
final class NotificationManager: ObservableObject {

    /// Stored user preference for whether daily check-ins are enabled.
    @AppStorage("dailyCheckInEnabled") private var dailyCheckInEnabled: Bool = false

    /// Public read-only access to the current setting.
    @Published private(set) var isDailyCheckInEnabled: Bool = false

    init() {
        isDailyCheckInEnabled = dailyCheckInEnabled
    }

    /// Keeps in-memory state in sync with AppStorage (used at app launch).
    func syncWithStoredPreference() {
        isDailyCheckInEnabled = dailyCheckInEnabled
        if isDailyCheckInEnabled {
            scheduleDailyCheckInIfAuthorized()
        } else {
            cancelDailyCheckIn()
        }
    }

    /// Updates the preference and schedules/cancels notifications accordingly.
    func setDailyCheckInEnabled(_ enabled: Bool) {
        dailyCheckInEnabled = enabled
        isDailyCheckInEnabled = enabled

        if enabled {
            requestAuthorizationIfNeeded { [weak self] granted in
                guard let self else { return }
                Task { @MainActor in
                    if granted {
                        self.scheduleDailyCheckIn()
                    } else {
                        self.dailyCheckInEnabled = false
                        self.isDailyCheckInEnabled = false
                    }
                }
            }
        } else {
            cancelDailyCheckIn()
        }
    }

    // MARK: - Authorization

    private func requestAuthorizationIfNeeded(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {

            case .authorized, .provisional:
                completion(true)

            case .ephemeral:
                // Temporary authorization (e.g. App Clips)
                completion(true)

            case .denied:
                completion(false)

            case .notDetermined:
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound]) { granted, _ in
                        completion(granted)
                    }

            @unknown default:
                completion(false)
            }
        }
    }

    // MARK: - Scheduling

    /// Public wrapper
    private func scheduleDailyCheckIn() {
        scheduleDailyCheckInIfAuthorized()
    }

    /// Schedules the daily notification at a gentle default time (10am).
    private func scheduleDailyCheckInIfAuthorized() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["withyou.daily.checkin"])

        let content = UNMutableNotificationContent()
        content.title = "WithYou"
        content.body = "How are you feeling today? If you’d like, you can open the app and talk for a moment."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "withyou.daily.checkin",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print("Failed to schedule daily check-in:", error)
            }
        }
    }

    /// Cancels all WithYou check-in notifications.
    private func cancelDailyCheckIn() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["withyou.daily.checkin"])
        UNUserNotificationCenter.current()
            .removeDeliveredNotifications(withIdentifiers: ["withyou.daily.checkin"])
    }
}
