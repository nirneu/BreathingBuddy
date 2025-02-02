import AVFoundation
import SwiftUI

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
            audioPlayer?.volume = 0.5
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
        isPlaying = false
    }
    
    func setVolume(_ volume: Float) {
        audioPlayer?.volume = volume
    }
    
    func cleanup() {
        stopSound()
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }
} 