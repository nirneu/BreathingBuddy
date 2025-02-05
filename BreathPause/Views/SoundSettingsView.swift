import SwiftUI

struct SoundSettingsView: View {
    @ObservedObject var soundManager: SoundManager
    @State private var showSoundPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Divider()
                .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Background Sound")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        showSoundPicker = true
                    }) {
                        HStack {
                            Text(soundManager.availableSounds[soundManager.selectedSound] ?? "None")
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                if soundManager.selectedSound != "none" {
                    HStack {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.secondary)
                        Slider(value: $soundManager.volume)
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
        }
        .sheet(isPresented: $showSoundPicker) {
            NavigationView {
                List {
                    ForEach(Array(soundManager.availableSounds.keys.sorted()), id: \.self) { key in
                        Button(action: {
                            if !soundManager.isPreviewPlaying {
                                soundManager.previewSound(key)
                            }
                            soundManager.selectedSound = key
                            showSoundPicker = false
                        }) {
                            HStack {
                                Text(soundManager.availableSounds[key] ?? "")
                                    .foregroundColor(.primary)
                                Spacer()
                                if soundManager.selectedSound == key {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Choose Sound")
                .navigationBarItems(trailing: Button("Done") {
                    showSoundPicker = false
                })
            }
        }
    }
}
