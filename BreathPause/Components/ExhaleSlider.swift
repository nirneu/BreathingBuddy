//
//  ExhaleSlider.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct ExhaleSlider: View {
    @Binding var exhaleDuration: Double

    var body: some View {
        HStack {
            Text("Exhale: \(Int(exhaleDuration))s")
            Slider(value: $exhaleDuration, in: BreathingConstants.minExhaleDuration...BreathingConstants.maxExhaleDuration, step: 1)
        }
    }
}

#Preview {
    ExhaleSlider(exhaleDuration: .constant(8))
}
