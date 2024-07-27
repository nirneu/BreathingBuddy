//
//  ContentView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var streakManager = StreakManager()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {

                    GeometryReader { geometry in
                             Image("PandaBackground")
                                 .resizable()
                                 .scaledToFit()
                                 .frame(width: geometry.size.width * 1, height: geometry.size.height * 1)
                         }
                         .aspectRatio(contentMode: .fit)

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
                        })) {
                            StyledButton(text: "Deep Breathing", color: Constants.primaryColor)
                        }

                        NavigationLink(destination: BreathFourSevenEightView(onExerciseComplete: {
                            streakManager.incrementStreakIfNeeded()
                        })) {
                            StyledButton(text: "4-7-8 Exercise", color: Constants.pandaColor)
                        }

                        NavigationLink(destination: BoxBreathingView(onExerciseComplete: {
                            streakManager.incrementStreakIfNeeded()
                        })) {
                            StyledButton(text: "Box Breathing", color: Constants.accentColor)
                        }

                        NavigationLink(destination: EightySecondCalmView(onExerciseComplete: {
                            streakManager.incrementStreakIfNeeded()
                        })) {
                            StyledButton(text: "Eighty-Second Calm", color: Constants.darkColor)
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()
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
                     .navigationBarHidden(false)
          
        }
        .addBanner()
        .environmentObject(StreakManager())
    }
}

#Preview {
    ContentView()
}

