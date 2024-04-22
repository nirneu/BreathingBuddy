import UIKit
import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        // Only request tracking if status is not determined
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
            requestTrackingPermission()
        } else {
            handleTrackingAuthorization(ATTrackingManager.trackingAuthorizationStatus)
        }

        return true
    }

    private func requestTrackingPermission() {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                self.handleTrackingAuthorization(status)
            }
        }
    }

    private func handleTrackingAuthorization(_ status: ATTrackingManager.AuthorizationStatus) {
        print("Authorization status after request: \(status.rawValue)")
        switch status {
        case .authorized:
            print("Tracking authorized by the user")
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        case .denied, .restricted:
            print("Tracking not authorized (denied or restricted)")
        case .notDetermined:
            print("Unexpected state: notDetermined after request")
        @unknown default:
            print("Unknown tracking authorization status")
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
