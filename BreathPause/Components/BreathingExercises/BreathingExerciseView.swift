//
//  BreathingExerciseView.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct BreathingExerciseView: View {
    @State private var selectedExercise = "Deep"
    @State private var inhaleDuration: Double = BreathingConstants.defaultInhaleDuration
    @State private var holdDuration: Double = BreathingConstants.defaultHoldDuration
    @State private var exhaleDuration: Double = BreathingConstants.defaultExhaleDuration
    @State private var cycles: Int = 5
    @State private var currentCycle = 0
    @State private var isAnimating = false
    @State private var phase = "Inhale"
    @State private var timeRemaining: Double = 0
    @State private var showInfo = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Choose Your Breathing Exercise")
                    .font(.title)
                    .padding()
                    .bold()

                Picker("Select Exercise", selection: $selectedExercise) {
                    Text("Deep").tag("Deep")
                    Text("Box").tag("Box")
                    Text("4-7-8").tag("4-7-8")
                    Text("Alt. Nostril").tag("Alternate Nostril")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedExercise) { newValue in
                    updateCyclesForSelectedExercise(newValue)
                }

                VStack {
                    if selectedExercise == "Deep" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                    } else if selectedExercise == "Box" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                    } else if selectedExercise == "4-7-8" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                        HoldSlider(holdDuration: $holdDuration)
                        ExhaleSlider(exhaleDuration: $exhaleDuration)
                    }
                }
                .padding()

                if selectedExercise != "Alternate Nostril" {
                    CycleStepper(cycles: $cycles)
                        .padding()
                }

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
                .padding()

                if isAnimating {
                    Text("Current Cycle: \(currentCycle)/\(cycles)")
                        .font(.title2)
                        .padding()
                    Text("Phase: \(phase)")
                        .font(.title2)
                        .padding()
                    Text("Time Remaining: \(Int(timeRemaining))s")
                        .font(.title3)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                showInfo.toggle()
            }) {
                Image(systemName: "info.circle")
            })
            .sheet(isPresented: $showInfo) {
                ExerciseInfoView(selectedExercise: $selectedExercise)
            }
        }
    }

    private func updateCyclesForSelectedExercise(_ exercise: String) {
        switch exercise {
        case "Deep":
            cycles = 5
        case "Box":
            cycles = 4
        case "4-7-8":
            cycles = 4
        case "Alternate Nostril":
            cycles = 5
        default:
            cycles = 5
        }
    }

    private func toggleBreathing() {
        isAnimating.toggle()
        if isAnimating {
            currentCycle = 0
            startBreathingCycle()
        } else {
            currentCycle = 0
            isAnimating = false
        }
    }

    private func startBreathingCycle() {
        guard currentCycle < cycles else {
            isAnimating = false
            return
        }

        switch selectedExercise {
        case "Box":
            runBoxBreathingCycle()
        case "4-7-8":
            run478BreathingCycle()
        case "Deep":
            runDeepBreathingCycle()
        case "Alternate Nostril":
            runNadiShodhanaBreathingCycle()
        default:
            break
        }
    }

    private func runBoxBreathingCycle() {
        phase = "Inhale"
        timeRemaining = inhaleDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + inhaleDuration) {
            self.phase = "Hold"
            self.timeRemaining = self.inhaleDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + self.inhaleDuration) {
                self.phase = "Exhale"
                self.timeRemaining = self.inhaleDuration
                DispatchQueue.main.asyncAfter(deadline: .now() + self.inhaleDuration) {
                    self.phase = "Hold"
                    self.timeRemaining = self.inhaleDuration
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.inhaleDuration) {
                        self.currentCycle += 1
                        self.startBreathingCycle()
                    }
                }
            }
        }
    }

    private func run478BreathingCycle() {
        phase = "Inhale"
        timeRemaining = inhaleDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + inhaleDuration) {
            self.phase = "Hold"
            self.timeRemaining = self.holdDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + self.holdDuration) {
                self.phase = "Exhale"
                self.timeRemaining = self.exhaleDuration
                DispatchQueue.main.asyncAfter(deadline: .now() + self.exhaleDuration) {
                    self.currentCycle += 1
                    self.startBreathingCycle()
                }
            }
        }
    }

    private func runDeepBreathingCycle() {
        phase = "Inhale"
        timeRemaining = inhaleDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + inhaleDuration) {
            self.phase = "Exhale"
            self.timeRemaining = self.inhaleDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + self.inhaleDuration) {
                self.currentCycle += 1
                self.startBreathingCycle()
            }
        }
    }

    private func runNadiShodhanaBreathingCycle() {
        phase = "Inhale Left"
        timeRemaining = inhaleDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + inhaleDuration) {
            self.phase = "Hold"
            self.timeRemaining = self.holdDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + self.holdDuration) {
                self.phase = "Exhale Right"
                self.timeRemaining = self.exhaleDuration
                DispatchQueue.main.asyncAfter(deadline: .now() + self.exhaleDuration) {
                    self.phase = "Inhale Right"
                    self.timeRemaining = self.inhaleDuration
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.inhaleDuration) {
                        self.phase = "Hold"
                        self.timeRemaining = self.holdDuration
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.holdDuration) {
                            self.phase = "Exhale Left"
                            self.timeRemaining = self.exhaleDuration
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.exhaleDuration) {
                                self.currentCycle += 1
                                self.startBreathingCycle()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BreathingExerciseView()
}
