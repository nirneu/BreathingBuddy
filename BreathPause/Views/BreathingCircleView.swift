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
    @State private var opacity: Double = 0.8
    @State private var rotation: Double = 0
    
    private var progress: CGFloat {
        CGFloat(timeRemaining / phaseDuration)
    }
    
    private var phaseColor: Color {
        switch phase {
        case "Inhale": return .blue
        case "Hold": return .green
        case "Exhale": return .orange
        default: return .gray
        }
    }
    
    var body: some View {
        ZStack {
            // Outer ripple effect
            ForEach(0..<3) { i in
                Circle()
                    .stroke(phaseColor.opacity(0.3), lineWidth: 2)
                    .scaleEffect(scale + Double(i) * 0.1)
                    .opacity(opacity - Double(i) * 0.2)
            }
            
            // Main breathing circle
            Circle()
                .stroke(phaseColor, lineWidth: 4)
                .scaleEffect(scale)
                .opacity(opacity)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(phaseColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .scaleEffect(scale)
            
            // Phase text
            VStack {
                Text(phase)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(phaseColor)
                
                Text(String(format: "%.0f", timeRemaining))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(phaseColor)
            }
        }
        .onChange(of: phase) { oldValue, newValue in
            withAnimation(.easeInOut(duration: phaseDuration)) {
                switch newValue {
                case "Inhale":
                    scale = 1.3
                    opacity = 1.0
                    rotation += 360
                case "Hold":
                    scale = 1.3
                    opacity = 0.8
                case "Exhale":
                    scale = 1.0
                    opacity = 0.6
                default:
                    scale = 1.0
                    opacity = 0.8
                }
            }
        }
    }
}
