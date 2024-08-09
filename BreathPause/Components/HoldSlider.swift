//
//  HoldSlider.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct HoldSlider: View {
    @Binding var holdDuration: Double

    var body: some View {
        HStack {
            Text("Hold: \(Int(holdDuration))s")
            Slider(value: $holdDuration, in: BreathingConstants.minHoldDuration...BreathingConstants.maxHoldDuration, step: 1)
        }
    }
}

#Preview {
    HoldSlider(holdDuration: .constant(7))
}
