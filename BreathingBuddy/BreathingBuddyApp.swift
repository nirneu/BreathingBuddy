//
//  BreathingBuddyApp.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    
    // Request for tracking permission
    requestTrackingPermission()
    
    return true
  }
  
  private func requestTrackingPermission() {
    // Check if the App Tracking Transparency permission dialog can be shown
    if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
      ATTrackingManager.requestTrackingAuthorization { status in
        switch status {
        case .authorized:
            // Tracking authorization dialog was shown
            // and we are authorized
            print("Tracking authorized by the user")
            // Here, you can start tracking
        case .denied:
            // Tracking authorization dialog was
            // shown and permission is denied
            print("Tracking denied by the user")
            // You might want to disable tracking functionality
        case .notDetermined:
            // Tracking permission dialog has not been shown
            print("Tracking permission not determined")
        case .restricted:
            // Tracking permission is restricted
            print("Tracking restricted")
        @unknown default:
            print("Unknown authorization status")
        }
      }
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
