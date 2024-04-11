//
//  ContentView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)
    private let secondaryColor = Color.white
    private let accentColor = Color(red: 0.3, green: 0.4, blue: 0.5)
    private let backgroundColor = Color(red: 0.9, green: 0.95, blue: 0.98)

    var body: some View {
        NavigationView {
            
            ZStack {
                // Background color extending to the screen edges
                backgroundColor.edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)

                    Text("BreathPause")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(primaryColor)
                        .multilineTextAlignment(.center)

                    Text("Find your breath, find your peace.")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(accentColor)
                        .multilineTextAlignment(.center)

                    Spacer()

                    // Navigation links for each breathing exercise
                    NavigationLink(destination: DeepBreathingView()) {
                        StyledButton(text: "Deep Breathing", color: primaryColor)
                            .foregroundColor(secondaryColor)
                    }

                    NavigationLink(destination: BreathFourSevenEightView()) {
                        StyledButton(text: "4-7-8 Exercise", color: Color(red: 0.2, green: 0.3, blue: 0.5))
                            .foregroundColor(secondaryColor)
                    }

                    NavigationLink(destination: BoxBreathingView()) {
                        StyledButton(text: "Box Breathing", color: Color(red: 0.8, green: 0.7, blue: 0.6))
                            .foregroundColor(secondaryColor)
                    }

                    NavigationLink(destination: GuidedBreathFocusView()) {
                        StyledButton(text: "Guided Breath Focus", color: accentColor)
                            .foregroundColor(secondaryColor)
                    }

                }
                .padding()
                .padding(.bottom, 30)
                
            }
            .navigationBarHidden(true)
//            .addBanner()
        }

    }
}


struct StyledButton: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(25)
            .shadow(radius: 5)

    }
}

#Preview {
    ContentView()
}
