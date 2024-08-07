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
    @State private var showStreakCongratulations = false
    private static var isFirebaseConfigured = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    GeometryReader { geometry in
                        VStack {
                            Image("PandaBackground")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)

                            Text("Breath Pause")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Constants.pandaColor)
                                .multilineTextAlignment(.center)

                            Text("Find your breath, find your peace.")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundColor(Constants.accentColor)
                                .multilineTextAlignment(.center)

                            Spacer()

                            VStack(spacing: 15) {
                                NavigationLink(destination: DeepBreathingView(onExerciseComplete: {
                                    streakManager.incrementStreakIfNeeded()
                                    checkForNewStreak()
                                })) {
                                    StyledButton(text: "Deep Breathing", color: Constants.primaryColor)
                                }

                                NavigationLink(destination: BreathFourSevenEightView(onExerciseComplete: {
                                    streakManager.incrementStreakIfNeeded()
                                    checkForNewStreak()
                                })) {
                                    StyledButton(text: "4-7-8 Exercise", color: Constants.pandaColor)
                                }

                                NavigationLink(destination: BoxBreathingView(onExerciseComplete: {
                                    streakManager.incrementStreakIfNeeded()
                                    checkForNewStreak()
                                })) {
                                    StyledButton(text: "Box Breathing", color: Constants.accentColor)
                                }

                                NavigationLink(destination: EightySecondCalmView(onExerciseComplete: {
                                    streakManager.incrementStreakIfNeeded()
                                    checkForNewStreak()
                                })) {
                                    StyledButton(text: "Eighty-Second Calm", color: Constants.darkColor)
                                }
                            }
                            .padding(.horizontal, 40)

                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            .navigationBarItems(trailing: HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.title3)

                Text("\(streakManager.currentStreak)")
                    .font(.title3)
                    .foregroundColor(.orange)
                    .fontWeight(.bold)
            })
            .sheet(isPresented: $showStreakCongratulations) {
                StreakCongratulationView(streakNumber: streakManager.currentStreak)
            }
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
            showStreakCongratulations = true
        }
    }
}

#Preview {
    ContentView()
}
