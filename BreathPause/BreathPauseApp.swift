import UIKit
import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // Set the notification center delegate
        UNUserNotificationCenter.current().delegate = self
        
        // Delay the ATT prompt to ensure the UI is ready
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.requestTrackingPermission { _ in }
        }
        
        // Request notification permission
        requestNotificationPermission()
        
        return true
    }
    
    func requestTrackingPermission(completion: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    completion(status)
                }
            }
        } else {
            completion(.authorized) // Treat older iOS versions as authorized for simplicity
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if granted {
                self.scheduleDailyNotification()
            }
        }
    }
    
    private func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time for Your Daily Exercise"
        content.body = "Don't forget to do your breathing exercise today!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "DAILY_REMINDER" // Optional: for grouping or actions
        content.userInfo = ["customData": "dailyReminder"] // Optional: custom data
        
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
