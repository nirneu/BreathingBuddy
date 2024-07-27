//
//  StreakManager.swift
//  BreathPause
//
//  Created by Nir Neuman on 27/07/2024.
//

import Foundation

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
    
    init() {
        self.currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
        self.lastUpdate = UserDefaults.standard.object(forKey: "lastUpdate") as? Date
    }
    
    func incrementStreakIfNeeded() {
        let now = Date()
        if let lastUpdate = lastUpdate {
            if !Calendar.current.isDateInToday(lastUpdate) {
                incrementStreak()
                self.lastUpdate = now
            }
        } else {
            incrementStreak()
            self.lastUpdate = now
        }
    }
    
    private func incrementStreak() {
        currentStreak += 1
    }
    
    func resetStreak() {
        currentStreak = 0
        lastUpdate = nil
    }
}

