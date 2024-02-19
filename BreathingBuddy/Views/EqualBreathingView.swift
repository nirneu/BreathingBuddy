//
//  EqualBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct EqualBreathingView: View {
    @State private var isBreathing = false
    
    var body: some View {
        VStack {
            Text("Equal Breathing Exercise")
                .font(.title)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 200, height: isBreathing ? 200 : 0)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                        self.isBreathing.toggle()
                    }
                }
        }
        .padding()
    }
}


#Preview {
    EqualBreathingView()
}
