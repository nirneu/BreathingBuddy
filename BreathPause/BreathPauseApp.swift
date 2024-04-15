import UIKit
import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        initializeAdMob()
        return true
    }

    private func initializeAdMob() {
        let status = ATTrackingManager.trackingAuthorizationStatus
        if status == .notDetermined {
            ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    self?.setupAdMobBasedOn(status: status)
                }
            }
        } else {
            setupAdMobBasedOn(status: status)
        }
    }

    private func setupAdMobBasedOn(status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            GADMobileAds.sharedInstance().start(completionHandler: nil)
            NotificationCenter.default.post(name: NSNotification.Name("TrackingAuthorizationDidChange"), object: nil, userInfo: ["authorized": true])
        case .denied, .restricted:
            NotificationCenter.default.post(name: NSNotification.Name("TrackingAuthorizationDidChange"), object: nil, userInfo: ["authorized": false])
        case .notDetermined:
            print("Unexpected state: notDetermined after request")
        @unknown default:
            print("Unknown tracking authorization status")
        }
    }

}

@main
struct BreathPauseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
