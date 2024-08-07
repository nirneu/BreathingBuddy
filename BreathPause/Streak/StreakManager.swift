//
//  StreakManager.swift
//  BreathPause
//
//  Created by Nir Neuman on 27/07/2024.
//

import Foundation
import Combine

class StreakManager: ObservableObject {
    @Published var currentStreak: Int {
        didSet {
            UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        }
    }
    
    @Published var lastUpdate: Date? {
        didSet {
            UserDefaults.standard.set(lastUpdate, forKey: "lastUpdate")
        }
    }
    
    @Published var isNewStreak: Bool = false
    
    init() {
        self.currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
        self.lastUpdate = UserDefaults.standard.object(forKey: "lastUpdate") as? Date
    }
    
    func incrementStreakIfNeeded() {
        let now = Date()
        
        if let lastUpdate = lastUpdate {
            if Calendar.current.isDateInToday(lastUpdate) {
                // Already updated today, do nothing
                return
            } else if !Calendar.current.isDate(lastUpdate, inSameDayAs: Calendar.current.date(byAdding: .day, value: -1, to: now)!) {
                // If the last update was not yesterday, reset the streak
                resetStreak()
            }
        }
        
        // Increment the streak
        incrementStreak()
        self.lastUpdate = now
        isNewStreak = true
    }
    
    private func incrementStreak() {
        currentStreak += 1
    }
    
    func resetStreak() {
        currentStreak = 0
        lastUpdate = nil
    }
}
