//
//  BreathingCircleView.swift
//  BreathPause
//
//  Created by Nir Neuman on 17/08/2024.
//

import SwiftUI

struct BreathingCircleView: View {
    @Binding var phase: String
    @Binding var timeRemaining: Double
    @Binding var phaseDuration: Double

    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Circle()
                .fill(phase.contains("Inhale") ? Color.green : (phase.contains("Exhale") ? Color.blue : Color.gray))
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
                .animation(.linear(duration: phaseDuration), value: scale)

            if timeRemaining > 0 {
                Text("\(Int(timeRemaining))s")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .padding()
        .onAppear {
            // Set initial scale without animation
            withAnimation(nil) {
                setScaleForCurrentPhase()
            }
        }
        .onChange(of: phase) {
            setScaleForCurrentPhase()
        }
    }

    private func setScaleForCurrentPhase() {
        switch phase {
        case _ where phase.contains("Inhale"):
            scale = 1.2  // Grow during inhale
        case _ where phase.contains("Exhale"):
            scale = 0.8  // Shrink during exhale
        case "Hold":
            // Keep current scale during hold
            break
        default:
            scale = 1.0
        }
    }
}
