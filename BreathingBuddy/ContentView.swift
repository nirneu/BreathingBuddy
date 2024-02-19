//
//  ContentView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 19/02/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DeepBreathingView()) {
                    Text("Deep Breathing")
                }
                NavigationLink(destination: BreathFourSevenEightView()) {
                    Text("4-7-8 Breathing")
                }
                NavigationLink(destination: EqualBreathingView()) {
                    Text("Equal Breathing")
                }
            }
            .navigationTitle("Breathing Exercises")
        }
    }
}


#Preview {
    ContentView()
}
