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
    
    let backgroundColor = Color(red: 0.95, green: 0.95, blue: 1.00)
    let circleColor = Color(red: 0.40, green: 0.60, blue: 0.92)
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Breathe In/Out Text
                Text(breatheOut ? "Breathe Out" : "Breathe In")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: isAnimating)
                
                // Correctly display cycles remaining
                Text("\(cyclesRemaining) breathes to go")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
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
                
                // Start/Pause Button
                Button(action: toggleBreathing) {
                    Text(isAnimating ? "Pause" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(isAnimating ? Color.red : Color.green)
                        .cornerRadius(20)
                }
                .padding(.bottom, 50)
            }
        }
    }
    
    func toggleBreathing() {
        isAnimating.toggle()
        
        if isAnimating {
            startBreathingCycle()
        }
    }
    
    func startBreathingCycle() {
        guard cyclesRemaining > 0 else {
            isAnimating = false
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
