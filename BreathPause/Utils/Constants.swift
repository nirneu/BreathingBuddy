//
//  Constants.swift
//  BreathPause
//
//  Created by Nir Neuman on 13/06/2024.
//

import SwiftUI

struct Constants {
    static let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.8) // Calming Blue
    static let secondaryColor = Color.white
    static let accentColor = Color(red: 0.3, green: 0.4, blue: 0.5) // Muted Gray
    static let backgroundColor = Color(red: 0.95, green: 0.98, blue: 0.99) // Soft Blue-White
    static let pandaColor = Color(red: 0.4, green: 0.7, blue: 0.8) // Light Blue-Green
    static let darkColor = Color(red: 0.1, green: 0.2, blue: 0.3) // Dark Gray-Blue
    static let textColor = Color(red: 0.3, green: 0.4, blue: 0.5)
    static let gradientStart = Color(red: 0.8, green: 0.9, blue: 1.0) // Light Gradient Start
    static let gradientEnd = Color(red: 0.6, green: 0.8, blue: 0.9) // Light Gradient End
}

struct BreathingConstants {
    static let defaultInhaleDuration: Double = 4
    static let defaultHoldDuration: Double = 7
    static let defaultExhaleDuration: Double = 8
    static let defaultCycleCount: Int = 5

    static let minInhaleDuration: Double = 3
    static let maxInhaleDuration: Double = 10

    static let minHoldDuration: Double = 4
    static let maxHoldDuration: Double = 7

    static let minExhaleDuration: Double = 5
    static let maxExhaleDuration: Double = 8
}

