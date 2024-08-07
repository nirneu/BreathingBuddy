//
//  GuidedBreathFocusView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 11/04/2024.
//

import SwiftUI

struct EightySecondCalmView: View {
    @State private var isBreathing = false
    @State private var breathCount = 0
    let maxBreathCount = 10
    @State private var secondsRemainingForBreath = 8
    @State private var showInfo = false
    
    var onExerciseComplete: (() -> Void)?

    private let backgroundColor =  Color(red: 0.9, green: 0.95, blue: 0.98)
    private let textColor = Color(red: 0.3, green: 0.4, blue: 0.5)
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                
                Text("Eighty-Second Calm")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.accentColor)
                    .multilineTextAlignment(.center)
                
                Text("Time for this breath: \(secondsRemainingForBreath) seconds")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.textColor)
                    .opacity(isBreathing ? 1 : 0)
                    .padding()
                
                
                Spacer()
                
                Text("Breaths: \(breathCount)/\(maxBreathCount)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.primaryColor)
                    .padding()
                

                Spacer()
                
                Button(action: toggleBreathing) {
                    Text(isBreathing ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(isBreathing ? Color.red : Color.green)
                        .cornerRadius(25)
                        .shadow(radius: 5)
    
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: {
                       showInfo.toggle()
                   }) {
                       Image(systemName: "info.circle")
                   })
                   .sheet(isPresented: $showInfo) {
                       InfoView(infoText: "Eighty-Second Calm: Focus on your breath. Inhale and exhale slowly. Each breath cycle takes 8 seconds. Try to reach ten breaths without getting distracted.")
                   }
        }
    }
    
    
    func toggleBreathing() {        
        if isBreathing {
            resetBreathing()
        } else {
            startBreathing()
        }
    }
    

    func startBreathing() {
        isBreathing = true
        breathCount = 0 // Reset the count when starting anew
        secondsRemainingForBreath = 8 // Reset the timer for each new breath
        startCountingBreaths()
    }

    func resetBreathing() {
        isBreathing = false
        breathCount = 0
        secondsRemainingForBreath = 8
    }

    func startCountingBreaths() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.secondsRemainingForBreath > 1 {
                self.secondsRemainingForBreath -= 1
            } else {
                self.breathCount += 1
                if self.breathCount >= self.maxBreathCount {
                    timer.invalidate()
                    self.isBreathing = false
                    self.onExerciseComplete?() // Notify the completion of the exercise
                } else {
                    self.secondsRemainingForBreath = 8
                }
            }
        }
        RunLoop.current.add(timer, forMode: .common)
    }
}


#Preview {
    EightySecondCalmView()
}
