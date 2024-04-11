//
//  FourSevenEightBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct BreathFourSevenEightView: View {
    @State private var isAnimating = false
    @State private var phase = "Prepare" // Start with Prepare phase
    @State private var secondsRemaining = 4 // Initialize with 0 for prepare phase
    @State private var timer: Timer? // Hold a reference to the timer to manage it
    private let totalCycles = 3
    @State private var cyclesCompleted = 0
    
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)
    private let backgroundColor = Color(red: 0.9, green: 0.95, blue: 0.98)
    private let accentColor = Color(red: 0.3, green: 0.4, blue: 0.5)

    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("4-7-8 Breathing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(accentColor)
                    .multilineTextAlignment(.center)
                
                Text("Take a moment to unwind. \n Inhale deeply through your nose for 4 seconds, pause and hold your breath for 7 seconds, then slowly exhale from your mouth for 8 seconds. Do this cycle three times.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(accentColor)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                // Visual representation of the breathing phase
                BreathVisualizer(phase: $phase, secondsRemaining: $secondsRemaining)
                    .frame(width: 300, height: 300)
                    .padding()
                
                Spacer()
                
                // Start/Stop Button
                Button(action: startStopBreathing) {
                    Text(isAnimating ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(isAnimating ? Color.red : Color.green)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                
                Spacer()
            }
        }
    }
    
    func startStopBreathing() {
            if isAnimating {
                // Stop the timer and reset the variables
                timer?.invalidate()
                timer = nil
                isAnimating = false
                phase = "Prepare"
                cyclesCompleted = 0
                secondsRemaining = 0
            } else {
                isAnimating = true
                cyclesCompleted = 0
                startBreathingCycle()
            }
        }
        
        func startBreathingCycle() {
            // Reset timer if it's already running
            timer?.invalidate()
            
            if phase == "Prepare" {
                phase = "Inhale"
                secondsRemaining = 4
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if secondsRemaining > 1 {
                    secondsRemaining -= 1
                } else {
                    switch phase {
                    case "Inhale":
                        phase = "Hold"
                        secondsRemaining = 7
                    case "Hold":
                        phase = "Exhale"
                        secondsRemaining = 8
                    case "Exhale":
                        cyclesCompleted += 1
                        if cyclesCompleted >= totalCycles {
                            // Exercise completed, stop timer and reset
                            timer?.invalidate()
                            timer = nil
                            isAnimating = false
                            phase = "Prepare" // Or set to "Done" if you want to show a completion state
                            cyclesCompleted = 0 // Reset cycles if needed
                        } else {
                            // Start next cycle
                            phase = "Inhale"
                            secondsRemaining = 4
                        }
                    default:
                        break // Should not reach here
                    }
                }
            }
        }
}

struct BreathVisualizer: View {
    @Binding var phase: String
    @Binding var secondsRemaining: Int
    
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)
    
    var body: some View {
        VStack {
            Text(phase)
                .font(.title)
                .fontWeight(.medium)
                .padding(.bottom, 20)
            
            if phase != "Prepare" {
                Text("\(secondsRemaining)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
        .foregroundStyle(primaryColor)
    }
}

#Preview {
    BreathFourSevenEightView()
}
