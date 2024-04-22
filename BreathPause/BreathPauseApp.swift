import UIKit
import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // Delay the ATT prompt to ensure the UI is ready
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.requestTrackingPermission { status in
                // Handle the authorization status here
                switch status {
                case .authorized:
                    print("ATT Status: Authorized - Can load personalized ads.")
                case .denied:
                    print("ATT Status: Denied - Should load non-personalized ads.")
                case .notDetermined:
                    print("ATT Status: Not Determined - Decision not yet made by user.")
                case .restricted:
                    print("ATT Status: Restricted - Cannot use tracking data.")
                @unknown default:
                    print("ATT Status: Unknown - Default handling.")
                }
            }
        }
        return true
    }
    
    
    func requestTrackingPermission(completion: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async { // Ensure UI updates or dependent actions are on the main thread
                    completion(status)
                }
            }
        } else {
            completion(.authorized) // Treat older iOS versions as authorized for simplicity
        }
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
