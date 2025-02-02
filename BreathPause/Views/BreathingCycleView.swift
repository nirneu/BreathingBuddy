//
//  BreathingCycleView.swift
//  BreathPause
//
//  Created by Nir Neuman on 17/08/2024.
//

import SwiftUI

struct BreathingPhase {
    let name: String
    let duration: Double
}

struct BreathingCycleView: View {
    @Binding var selectedExercise: String
    @Binding var inhaleDuration: Double
    @Binding var holdDuration: Double
    @Binding var exhaleDuration: Double
    @Binding var cycles: Int
    
    @EnvironmentObject var streakManager: StreakManager

    @State private var currentCycle = 0
    @State private var phase = "Inhale"
    @State private var timeRemaining: Double = 0
    @State private var phaseDuration: Double = 0.0
    @State private var phases: [BreathingPhase] = []
    @State private var phaseIndex = 0
    @State private var timer: Timer? = nil

    @Environment(\.presentationMode) var presentationMode

    private var remainingCycles: Int {
        return cycles - currentCycle
    }

    var body: some View {
        VStack {

                VStack {
                    Text("Phase: \(phase)")
                        .font(.title)
                        .padding(.bottom, 8)

                    Text("Cycles Remaining: \(remainingCycles)")
                        .font(.headline)
                    
                    BreathingCircleView(phase: $phase, timeRemaining: $timeRemaining, phaseDuration: $phaseDuration)
                        .frame(width: 300, height: 300)
                        .padding()

//                    Spacer()

                    Button(action: endBreathingCycle) {
                        Text("End Exercise")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 20) 
                }
                .padding(.bottom, 50)
            }
            .onAppear(perform: startBreathingCycle)
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
            .navigationBarHidden(true)
            .addBanner()

            Spacer()

    }


    private func startBreathingCycle() {
        currentCycle = 0
        phaseIndex = 0
        setupPhases()
        nextPhase()
    }

    private func setupPhases() {
        phases.removeAll()
        switch selectedExercise {
        case "Box":
            let phaseSequence = [
                BreathingPhase(name: "Inhale", duration: inhaleDuration),
                BreathingPhase(name: "Hold", duration: inhaleDuration),
                BreathingPhase(name: "Exhale", duration: inhaleDuration),
                BreathingPhase(name: "Hold", duration: inhaleDuration)
            ]
            phases = Array(repeating: phaseSequence, count: cycles).flatMap { $0 }
        case "4-7-8":
            let phaseSequence = [
                BreathingPhase(name: "Inhale", duration: inhaleDuration),
                BreathingPhase(name: "Hold", duration: holdDuration),
                BreathingPhase(name: "Exhale", duration: exhaleDuration)
            ]
            phases = Array(repeating: phaseSequence, count: cycles).flatMap { $0 }
        case "Deep":
            let phaseSequence = [
                BreathingPhase(name: "Inhale", duration: inhaleDuration),
                BreathingPhase(name: "Exhale", duration: inhaleDuration)
            ]
            phases = Array(repeating: phaseSequence, count: cycles).flatMap { $0 }
        case "Alternate Nostril":
            let phaseSequence = [
                // Left nostril
                BreathingPhase(name: "Inhale Left", duration: inhaleDuration),
                BreathingPhase(name: "Hold", duration: holdDuration),
                BreathingPhase(name: "Exhale Right", duration: exhaleDuration),
                BreathingPhase(name: "Hold", duration: holdDuration),
                // Right nostril
                BreathingPhase(name: "Inhale Right", duration: inhaleDuration),
                BreathingPhase(name: "Hold", duration: holdDuration),
                BreathingPhase(name: "Exhale Left", duration: exhaleDuration),
                BreathingPhase(name: "Hold", duration: holdDuration)
            ]
            phases = Array(repeating: phaseSequence, count: cycles).flatMap { $0 }
        default:
            break
        }
    }

    private func nextPhase() {
        guard phaseIndex < phases.count else {
            // Exercise completed naturally
            streakManager.incrementStreakIfNeeded()
            endBreathingCycle()
  
            return
        }

        let currentPhase = phases[phaseIndex]
        phase = currentPhase.name
        phaseDuration = currentPhase.duration
        timeRemaining = currentPhase.duration

        // Start the timer
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timer = nil
                phaseIndex += 1
                if phaseIndex % phasesPerCycle() == 0 {
                    currentCycle += 1
                }
                nextPhase()
            }
        }
    }

    private func phasesPerCycle() -> Int {
        switch selectedExercise {
        case "Box":
            return 4
        case "4-7-8":
            return 3
        case "Deep":
            return 2
        case "Alternate Nostril":
            return 8 // Updated from 6 to 8 due to the extra hold phases
        default:
            return 1
        }
    }

    private func endBreathingCycle() {
        timer?.invalidate()
        timer = nil
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    BreathingCycleView(
        selectedExercise: .constant("Deep"),
        inhaleDuration: .constant(4),
        holdDuration: .constant(4),
        exhaleDuration: .constant(4),
        cycles: .constant(5)
    )
    .environmentObject(StreakManager())
}
