//
//  StyledButton.swift
//  BreathPause
//
//  Created by Nir Neuman on 11/06/2024.
//

import SwiftUI

struct StyledButton: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(25)
            .shadow(radius: 5)
            .foregroundColor(Constants.secondaryColor)
    }
}
