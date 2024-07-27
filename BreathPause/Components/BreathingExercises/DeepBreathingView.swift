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
    @State private var showInfo = false

    let totalCycles = 5
    let animationDuration: Double = 5
    let circleStartSize: CGFloat = 150
    let circleEndSize: CGFloat = 250
    
    var onExerciseComplete: (() -> Void)?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                Text("Deep Breathing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.accentColor)
                    .multilineTextAlignment(.center)
                                
                Text("\(cyclesRemaining) breathes to go")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Constants.textColor)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeInOut, value: cyclesRemaining)
                    .padding(.top)
                
                Spacer()
                                
                Circle()
                    .fill(Constants.primaryColor)
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
                        .background(isAnimating ? Color.red : Color.green)
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
                       InfoView(infoText: "Deep Breathing: Let's focus on deep breathing. \nGently breathe in deeply through your nose, filling your lungs completely, and then exhale slowly through your mouth. Aim for 5 complete breath cycles to help calm your mind and body.")
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
            self.onExerciseComplete?() // Notify the completion of the exercise
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

