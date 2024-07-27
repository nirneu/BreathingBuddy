//
//  StreakCongratulationView.swift
//  BreathPause
//
//  Created by Nir Neuman on 27/07/2024.
//

import SwiftUI

struct StreakCongratulationView: View {
    let streakNumber: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("PandaThumb")
                    .resizable()
                    .scaledToFit()
                    .padding()

                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundStyle(Constants.primaryColor)

                Text("You've achieved a new streak of \(streakNumber) days!")
                    .font(.title)
                    .padding()
                    .foregroundStyle(Constants.accentColor)

                Button("Close") {
                    dismiss()
                }
                .font(.headline)
                .padding()
                .foregroundStyle(Constants.primaryColor)
            }
            .padding()

            ConfettiView()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    StreakCongratulationView(streakNumber: 1)
}

