//
//  ConfettiView.swift
//  BreathPause
//
//  Created by Nir Neuman on 27/07/2024.
//

import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    @State private var showConfetti = true

    var body: some View {
        ZStack {
            if showConfetti {
                ForEach(0..<100, id: \.self) { _ in
                    ConfettiShape()
                        .rotationEffect(.degrees(Double.random(in: 0...360)))
                        .offset(x: CGFloat.random(in: -200...200), y: animate ? 600 : -600)
                        .animation(
                            Animation.linear(duration: Double.random(in: 2...4))
                                .repeatForever(autoreverses: false),
                            value: animate
                        )
                }
            }
        }
        .onAppear {
            withAnimation {
                animate = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Stop confetti after 3 seconds
                showConfetti = false
            }
        }
    }
}

struct ConfettiShape: View {
    var body: some View {
        Circle()
            .fill(Color.random)
            .frame(width: 10, height: 10)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    ConfettiView()
}
