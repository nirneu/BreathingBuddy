//
//  CycleStepper.swift
//  BreathPause
//
//  Created by Nir Neuman on 09/08/2024.
//

import SwiftUI

struct CycleStepper: View {
    @Binding var cycles: Int

    var body: some View {
        HStack {
            Text("Cycles: \(cycles)")
            Stepper("", value: $cycles, in: 1...10)
        }
    }
}

#Preview {
    CycleStepper(cycles: .constant(5))
}
