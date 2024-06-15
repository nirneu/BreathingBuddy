//
//  BreathingPanda.swift
//  BreathPause
//
//  Created by Nir Neuman on 13/06/2024.
//

import SwiftUI

struct BreathingPanda: View {

    var body: some View {
        ZStack {
            Image("panda_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    BreathingPanda()
}

