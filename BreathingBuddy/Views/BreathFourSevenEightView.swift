//
//  FourSevenEightBreathingView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

struct BreathFourSevenEightView: View {
    @State private var countdown = 4
    @State private var isBreathing = false
    
    var body: some View {
        VStack {
                   Text("4-7-8 Breathing Exercise")
                       .font(.title)
                   Text("\(countdown)")
                       .font(.title)
                       .foregroundColor(.blue)
                       .onAppear() {
                           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                               if self.countdown > 0 {
                                   self.countdown -= 1
                               } else {
                                   timer.invalidate()
                                   self.countdown = 4
                                   self.isBreathing.toggle()
                               }
                           }
                       }
                       .onDisappear() {
                           self.countdown = 4
                       }
               }
               .padding()
    }
}
#Preview {
    BreathFourSevenEightView()
}
