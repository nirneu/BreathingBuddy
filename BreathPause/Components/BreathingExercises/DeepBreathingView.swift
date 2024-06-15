//
//  DeepBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//
import SwiftUI

struct DeepBreathingView: View {
    @State private var isAnimating = false
    @State private var breatheOut = false
    @State private var cyclesRemaining = 5
    let totalCycles = 5
    
    let animationDuration: Double = 5
    let circleStartSize: CGFloat = 150
    let circleEndSize: CGFloat = 250
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Deep Breathing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.primaryColor)
                    .multilineTextAlignment(.center)
                
                Text("Let's focus on deep breathing. \n Gently breathe in deeply through your nose, filling your lungs completely, and then exhale slowly through your mouth. Aim for 5 complete breath cycles to help calm your mind and body.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Constants.accentColor)
                    .multilineTextAlignment(.center)
                    .padding()
                                
                Text(breatheOut ? "Breathe Out" : "Breathe In")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Constants.textColor)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: isAnimating)
                
                Text("\(cyclesRemaining) breathes to go")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Constants.textColor)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: cyclesRemaining)
                
                Spacer()
                
                Circle()
                    .fill(Constants.pandaColor)
                    .frame(width: circleStartSize, height: circleStartSize)
                    .scaleEffect(breatheOut ? 1.5 : 1)
                    .animation(.easeInOut(duration: animationDuration), value: breatheOut)
                
                Spacer()
                
                Button(action: toggleBreathing) {
                    Text(isAnimating ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(isAnimating ? Color.red : Constants.primaryColor)
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

