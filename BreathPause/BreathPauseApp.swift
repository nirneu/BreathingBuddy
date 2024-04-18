import UIKit
import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        requestTrackingAuthorization()
        return true
    }

    private func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                self.initializeAdMobBasedOn(status: status)
            }
        }
    }

    private func initializeAdMobBasedOn(status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            GADMobileAds.sharedInstance().start(completionHandler: nil)
            NotificationCenter.default.post(name: NSNotification.Name("TrackingAuthorizationDidChange"), object: nil, userInfo: ["authorized": true])
        case .denied, .restricted:
            NotificationCenter.default.post(name: NSNotification.Name("TrackingAuthorizationDidChange"), object: nil, userInfo: ["authorized": false])
        case .notDetermined:
            print("Error: ATT status not determined post-request")
        @unknown default:
            print("Unknown ATT status encountered")
        }
    }
}

@main
struct BreathPauseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
