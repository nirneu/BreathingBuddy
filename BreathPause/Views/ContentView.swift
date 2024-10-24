//
//  ContentView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI
import AppTrackingTransparency
import FirebaseCore
import GoogleMobileAds

struct ContentView: View {
    @StateObject private var streakManager = StreakManager()
    private static var isFirebaseConfigured = false

    var body: some View {
        NavigationView {
            BreathingExerciseView()
                .navigationBarItems(trailing: HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.title3)

                    Text("\(streakManager.currentStreak)")
                        .font(.title3)
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                })
        }
        .addBanner()
        .environmentObject(streakManager)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if #available(iOS 14, *) {
                let status = ATTrackingManager.trackingAuthorizationStatus
                if status == .notDetermined {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        self.initializeSDKs()
                    }
                } else {
                    self.initializeSDKs()
                }
            } else {
                self.initializeSDKs()
            }
        }
        .onReceive(streakManager.$isNewStreak) { isNewStreak in
                  if isNewStreak {
                      streakManager.isNewStreak = false
                  }
              }
    }

    private func initializeSDKs() {
        if !ContentView.isFirebaseConfigured {
            ContentView.isFirebaseConfigured = true
            FirebaseApp.configure()
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
    }

    private func checkForNewStreak() {
        if streakManager.isNewStreak {
            streakManager.isNewStreak = false
        }
    }
}

#Preview {
    ContentView()
}
