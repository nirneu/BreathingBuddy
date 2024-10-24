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
                .font(.title3)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }

    func exerciseInfo(for exercise: String) -> String {
        switch exercise {
        case "Deep":
            return """

            Deep breathing is one of the most fundamental and effective techniques for relaxation and stress management. By taking slow, deep breaths, you activate your parasympathetic nervous system, which helps to lower your heart rate and reduce the body's stress response.

            Recommended Duration: 4-6 seconds per inhale and exhale.
            Recommended Cycles: 5 cycles.

            Benefits: Deep breathing is known to improve focus, increase oxygen intake, and promote a state of calmness. It’s a great exercise to perform at any time when you need to unwind or re-center yourself.
            """
        case "Box":
            return """

            Box breathing, also known as four-square breathing, is a simple but powerful exercise often used by athletes and even Navy SEALs to maintain focus and calm under pressure. It involves equal intervals of inhaling, holding, exhaling, and holding again.

            Recommended Duration: 4 seconds for each phase.
            Recommended Cycles: 4 cycles.

            Benefits: Box breathing helps to balance your autonomic nervous system, enhances concentration, and is a great technique for grounding yourself during moments of high stress.
            """
        case "4-7-8":
            return """

            The 4-7-8 technique is a scientifically-backed exercise that combines controlled breathing with mindfulness. This method helps to bring your body into a deep state of relaxation.

            Recommended Duration: 4 seconds for inhale, 7 seconds for hold, 8 seconds for exhale.
            Recommended Cycles: 4 cycles.

            Benefits: This exercise is particularly effective in helping people fall asleep faster, reduce anxiety, and manage cravings. It’s an excellent practice to incorporate into your bedtime routine or whenever you feel overwhelmed.
            """
        case "Alternate Nostril":
            return """
            
            Alternate nostril breathing is a traditional yogic practice that balances the mind and body. It involves inhaling through one nostril, holding the breath, exhaling through the other nostril, and holding again, then repeating the process on the opposite side.

            Recommended Duration: 4 seconds for inhale, 4 seconds for hold, 4 seconds for exhale, 4 seconds for hold.
            Recommended Cycles: 5 cycles.

            Benefits: This practice is known to improve mental clarity, enhance lung function, and promote a sense of harmony within the body. It’s especially useful for reducing anxiety and improving focus before meditation or important tasks.
            """
        default:
            return ""
        }
    }
}

#Preview {
    ExerciseInfoView(selectedExercise: .constant("Box"))
}
