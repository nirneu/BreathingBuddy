//
//  ContentView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Image("panda_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 300)

                    Text("Breathing Buddy")
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
                        NavigationLink(destination: DeepBreathingView()) {
                            StyledButton(text: "Deep Breathing", color: Constants.primaryColor)
                        }

                        NavigationLink(destination: BreathFourSevenEightView()) {
                            StyledButton(text: "4-7-8 Exercise", color: Constants.pandaColor)
                        }

                        NavigationLink(destination: BoxBreathingView()) {
                            StyledButton(text: "Box Breathing", color: Constants.accentColor)
                        }

                        NavigationLink(destination: GuidedBreathFocusView()) {
                            StyledButton(text: "Guided Breath Focus", color: Constants.textColor)
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
                .padding(.bottom, 30)
                .addBanner()
            }
            .navigationBarHidden(true)
          
        }
        
    }
}

#Preview {
    ContentView()
}

