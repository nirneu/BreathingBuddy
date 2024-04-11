//
//  DeepBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct DeepBreathingView: View {
    
    @State private var isAnimating = false
    @State private var breatheOut = false // Toggle for breathing animation direction
    @State private var cyclesRemaining = 5 // Total breathing cycles remaining
    let totalCycles = 5 // Total breathing cycles
    
    let animationDuration: Double = 5 // Duration for each breathe in/out
    let circleStartSize: CGFloat = 150
    let circleEndSize: CGFloat = 250
    
    private let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8)
    private let backgroundColor = Color(red: 0.9, green: 0.95, blue: 0.98)
    private let accentColor = Color(red: 0.3, green: 0.4, blue: 0.5)
    let circleColor = Color(red: 0.2, green: 0.6, blue: 0.8)
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Text("Deep Breathing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(accentColor)
                    .multilineTextAlignment(.center)
                
                Text("Let's focus on deep breathing. \n Gently breathe in deeply through your nose, filling your lungs completely, and then exhale slowly through your mouth. Aim for 5 complete breath cycles to help calm your mind and body.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(accentColor)
                    .multilineTextAlignment(.center)
                    .padding()
                                
                // Breathe In/Out Text
                Text(breatheOut ? "Breathe Out" : "Breathe In")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(accentColor)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: isAnimating)
                
                // Correctly display cycles remaining
                Text("\(cyclesRemaining) breathes to go")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(accentColor)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: cyclesRemaining)
                
                Spacer()
                
                // Breathing Circle
                Circle()
                    .fill(circleColor)
                    .frame(width: circleStartSize, height: circleStartSize)
                    .scaleEffect(breatheOut ? 1.5 : 1)
                    .animation(.easeInOut(duration: animationDuration), value: breatheOut)
                
                Spacer()
                
                    // Start/Stop Button
                    Button(action: toggleBreathing) {
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
    
    func toggleBreathing() {
        isAnimating.toggle()
        
        if isAnimating {
            startBreathingCycle()
        } else {
            isAnimating = false
            breatheOut = false
            cyclesRemaining = totalCycles
        }
    }
    
    func startBreathingCycle() {
        guard cyclesRemaining > 0 else {
            isAnimating = false
            breatheOut = false
            cyclesRemaining = totalCycles
            return
        }
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            breatheOut.toggle()
        }
        
        // Decrement cycles remaining at the end of each 'breathe out' to accurately reflect a full cycle
        if breatheOut {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                if self.isAnimating {
                    self.cyclesRemaining -= 1
                    self.startBreathingCycle()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                if self.isAnimating {
                    self.startBreathingCycle()
                }
            }
        }
    }
    
}

#Preview {
    DeepBreathingView()
}
