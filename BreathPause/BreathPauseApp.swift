import UIKit
import SwiftUI
import GoogleMobileAds
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // A flag to manage notification enable/disable state
    private var areNotificationsEnabled = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set the notification center delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Request notification permission if notifications are enabled
        if areNotificationsEnabled {
            requestNotificationPermission()
        } else {
            clearExistingNotifications()
        }
        
        return true
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if granted {
                self.clearExistingNotifications()
                self.scheduleDailyNotification()
            }
        }
    }

    private func clearExistingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notifications cleared")
    }
    
    private func scheduleDailyNotification() {
        guard areNotificationsEnabled else { return } // Don't schedule notifications if disabled
        
        let content = UNMutableNotificationContent()
        content.title = "Time for Your Daily Exercise"
        content.body = "Don't forget to do your breathing exercise today!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "DAILY_REMINDER"
        content.userInfo = ["customData": "dailyReminder"]
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10 // 10 AM
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    // Handle notification presentation when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound, .badge])
        } else {
            completionHandler([.alert, .sound, .badge])
        }
    }
    
    // Handle notification response
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

@main
struct BreathingBuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
