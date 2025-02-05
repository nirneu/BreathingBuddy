//
//  SoundsManager.swift
//  BreathPause
//
//  Created by Nir Nils Neuman on 02/02/2025.
//

import AVFoundation
import SwiftUI

@MainActor
class SoundManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var selectedSound: String = "none" {
        didSet {
            if selectedSound != "none" {
                loadAndPlaySound()
            } else {
                stopSound()
            }
        }
    }
    
    @Published var soundLoadError: String?
    
    let availableSounds = [
        "none": "None",
        "rain": "Gentle Rain",
        "forest": "Forest Ambience"
    ]
    
    @Published var volume: Float = 0.5 {
        didSet {
            audioPlayer?.volume = volume
            if !isPlaying && selectedSound != "none" {
                // Preview sound when volume changes and sound isn't playing
                previewSound(selectedSound)
            }
        }
    }
    
    static let shared = SoundManager()
    
    private var previewTimer: Timer?
    @Published var isPreviewPlaying = false
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    private func loadAndPlaySound() {
        configureAudioSession()
        guard selectedSound != "none" else { return }
        
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "mp3") else {
            soundLoadError = "Could not find sound file: \(selectedSound)"
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = volume
            audioPlayer?.play()
            isPlaying = true
            soundLoadError = nil
        } catch {
            soundLoadError = "Failed to play sound: \(error.localizedDescription)"
            print("Failed to play sound: \(error)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
    }
    
    func cleanup() {
        stopSound()
        previewTimer?.invalidate()
        previewTimer = nil
        isPreviewPlaying = false
    }
    
    func previewSound(_ soundKey: String) {
        guard soundKey != "none" else { return }
        stopSound()
        selectedSound = soundKey
        isPreviewPlaying = true
        
        previewTimer?.invalidate()
        previewTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            Task { @MainActor in
                self?.stopPreview()
            }
        }
    }
    
    private func stopPreview() {
        previewTimer?.invalidate()
        previewTimer = nil
        stopSound()
        isPreviewPlaying = false
    }
    
    func startExerciseSound() {
        if isPreviewPlaying {
            stopPreview()
        }
        if selectedSound != "none" {
            loadAndPlaySound()
        }
    }
}
