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
    @State private var showInfo = false
    @State private var forgroundColor = Constants.accentColor
    
    let totalCycles = 3 // Default number of total cycles
    
    var onExerciseComplete: (() -> Void)?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                
                Spacer()
                
                Text("Box Breathing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.accentColor)
                                
                Text("Cycles Completed: \(cyclesCompleted) / \(totalCycles)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.textColor)
                    .opacity(isAnimating ? 1 : 0)
                    .padding(.top)
                
                Spacer()
                
                BreathVisualizer(phase: $phase, secondsRemaining: $secondsRemaining)
                    .frame(width: 300, height: 150)
                
                
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
            .navigationBarItems(trailing: Button(action: {
                       showInfo.toggle()
                   }) {
                       Image(systemName: "info.circle")
                   })
                   .sheet(isPresented: $showInfo) {
                       InfoView(infoText: "Box Breathing: Breathe in sync with the box pattern: Inhale, hold, exhale, hold, each for 4 seconds.")
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
            self.onExerciseComplete?() // Notify the completion of the exercise
        }
    }
}


#Preview {
    BoxBreathingView()
}
