//
//  BoxBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 11/04/2024.
//

import SwiftUI

struct BoxBreathingView: View {
    @State private var phase = "Prepare" // Start with the prepare phase
    @State private var secondsRemaining = 4 // Time for each phase
    @State private var isAnimating = false
    @State private var timer: Timer?
    @State private var cyclesCompleted = 0 // Track the number of completed cycles
    let totalCycles = 3 // Default number of total cycles

    private let backgroundColor =  Color(red: 0.9, green: 0.95, blue: 0.98)
    private let textColor = Color(red: 0.3, green: 0.4, blue: 0.5)
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)


    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Box Breathing Exercise")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                
                Text("Breathe in sync with the box pattern: Inhale, hold, exhale, hold, each for 4 seconds.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(textColor)
                    .padding()
                    .multilineTextAlignment(.center)
                
                BreathVisualizer(phase: $phase, secondsRemaining: $secondsRemaining)
                    .frame(width: 300, height: 300)
                
                Text("Cycles Completed: \(cyclesCompleted) / \(totalCycles)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(textColor)
                
                Spacer()
                
                Button(action: {
                    if isAnimating {
                        stopBreathing()
                    } else {
                        startBreathing()
                    }
                }) {
                    Text(isAnimating ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                }
                .background(isAnimating ? Color.red : Color.green)
                .cornerRadius(25)
                .shadow(radius: 5)


                Spacer()
            }
        }
    }

    func startBreathing() {
        isAnimating = true
        phase = "Inhale"
        secondsRemaining = 4
        cyclesCompleted = 0 // Reset cycles on new start
        startTimer()
    }

    func stopBreathing() {
        timer?.invalidate()
        timer = nil
        isAnimating = false
        phase = "Prepare"
        secondsRemaining = 4
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondsRemaining > 1 {
                self.secondsRemaining -= 1
            } else {
                self.switchPhase()
            }
        }
    }

    func switchPhase() {
        switch phase {
        case "Inhale":
            phase = "Hold after inhale"
        case "Hold after inhale":
            phase = "Exhale"
        case "Exhale":
            phase = "Hold after exhale"
        case "Hold after exhale":
            phase = "Inhale"
            completeCycle()
        default:
            phase = "Prepare"
        }
        secondsRemaining = 4
    }
    
    func completeCycle() {
        cyclesCompleted += 1
        if cyclesCompleted >= totalCycles {
            stopBreathing()
        }
    }
}


#Preview {
    BoxBreathingView()
}
