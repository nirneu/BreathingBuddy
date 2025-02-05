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
    @State private var showInfo = false
    @State private var showExerciseScreen = false
    
    @EnvironmentObject var streakManager: StreakManager
    @StateObject private var soundManager = SoundManager.shared

    var body: some View {
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
            .onChange(of: selectedExercise) { oldValue, newValue in
                updateSettingsForSelectedExercise(newValue)
            }

            // Use ScrollView only for the adjustable components
            ScrollView {
                VStack {
                    if selectedExercise == "Deep" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                    } else if selectedExercise == "Box" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                    } else if selectedExercise == "4-7-8" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                        HoldSlider(holdDuration: $holdDuration)
                        ExhaleSlider(exhaleDuration: $exhaleDuration)
                    } else if selectedExercise == "Alternate Nostril" {
                        InhaleSlider(inhaleDuration: $inhaleDuration)
                        HoldSlider(holdDuration: $holdDuration)
                        ExhaleSlider(exhaleDuration: $exhaleDuration)
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    CycleStepper(cycles: $cycles)
                        .padding()

                    SoundSettingsView(soundManager: soundManager)
                }
            }

            Button(action: { showExerciseScreen.toggle() }) {
                Text("Start Exercise")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(25)
                    .shadow(radius: 5)
            }
            .padding()
            .fullScreenCover(isPresented: $showExerciseScreen) {
                BreathingCycleView(
                    selectedExercise: $selectedExercise,
                    inhaleDuration: $inhaleDuration,
                    holdDuration: $holdDuration,
                    exhaleDuration: $exhaleDuration,
                    cycles: $cycles
                )
                .environmentObject(streakManager)
            }

            Spacer(minLength: 0) // This pushes the content up if there's extra space
        }
        .padding()
        .navigationBarItems(
            leading: Button(action: {
                showInfo.toggle()
            }) {
                Image(systemName: "info.circle")
            }
        )
        .sheet(isPresented: $showInfo) {
            ExerciseInfoView(selectedExercise: $selectedExercise)
        }
        .padding(.bottom, 50) // Adjust this value based on your ad banner's height
        .environmentObject(soundManager)
    }

    private func updateSettingsForSelectedExercise(_ exercise: String) {
        switch exercise {
        case "Deep":
            inhaleDuration = 4
            cycles = 5
        case "Box":
            inhaleDuration = 4
            cycles = 4
        case "4-7-8":
            inhaleDuration = 4
            holdDuration = 7
            exhaleDuration = 8
            cycles = 4
        case "Alternate Nostril":
            inhaleDuration = 4
            holdDuration = 4
            exhaleDuration = 4
            cycles = 5
        default:
            cycles = 5
        }
    }
}

#Preview {
    BreathingExerciseView()
        .environmentObject(StreakManager())
}
