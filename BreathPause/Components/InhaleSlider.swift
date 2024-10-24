//
//  InhaleSlider.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct InhaleSlider: View {
    @Binding var inhaleDuration: Double

    var body: some View {
        HStack {
            Text("Inhale: \(Int(inhaleDuration))s")
            Slider(value: $inhaleDuration, in: BreathingConstants.minInhaleDuration...BreathingConstants.maxInhaleDuration, step: 1)
        }
    }
}

#Preview {
    InhaleSlider(inhaleDuration: .constant(4))
}

