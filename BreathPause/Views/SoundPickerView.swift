import SwiftUI

struct SoundPickerView: View {
    @ObservedObject var soundManager: SoundManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(soundManager.availableSounds.keys.sorted()), id: \.self) { key in
                    HStack {
                        Text(soundManager.availableSounds[key] ?? "")
                        Spacer()
                        if soundManager.selectedSound == key {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        soundManager.selectedSound = key
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Background Sounds")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 