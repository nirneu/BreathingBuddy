//
//  ExerciseInfoView.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct ExerciseInfoView: View {
    @Binding var selectedExercise: String

    var body: some View {
        VStack {
            Text(selectedExercise)
                .font(.largeTitle)
                .padding()

            Text(exerciseInfo(for: selectedExercise))
                .padding()

            Spacer()
        }
    }

    func exerciseInfo(for exercise: String) -> String {
        switch exercise {
        case "Deep":
            return "Deep Breathing: Breathe deeply through your nose, filling your lungs completely, and then exhale slowly through your mouth."
        case "Box":
            return "Box Breathing: Inhale, hold, exhale, and hold again, each for the same amount of time."
        case "4-7-8":
            return "4-7-8 Breathing: Inhale for 4 seconds, hold for 7 seconds, and exhale for 8 seconds."
        case "Alternate Nostril":
            return "Alternate Nostril Breathing: Inhale through the left nostril, hold, exhale through the right nostril. Then inhale through the right nostril, hold, and exhale through the left."
        default:
            return ""
        }
    }
}

#Preview {
    ExerciseInfoView(selectedExercise: .constant("Box Breathing"))
}
