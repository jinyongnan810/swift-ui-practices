//
//  SoundListView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/18.
//

import SwiftUI

struct SoundListView: View {
    @Binding var selectedSound: Sounds
    var body: some View {
        List {
            Section("Ring Tone") {
                ForEach(ringToneSoundsList, id: \.self) { sound in
                    SoundItemView(sound: sound, isSelected: selectedSound == sound)
                        .onTapGesture {
                            selectedSound = sound
                        }
                }
            }
            Section("Nature Tone") {
                ForEach(natureSoundsList, id: \.self) { sound in
                    SoundItemView(sound: sound, isSelected: selectedSound == sound)
                        .onTapGesture {
                            selectedSound = sound
                        }
                }
            }
        }
    }
}

struct SoundItemView: View {
    let sound: Sounds
    let isSelected: Bool
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .symbolEffect(.bounce, value: isSelected)
                .imageScale(.large)
                .foregroundStyle(.myPink)
                .opacity(isSelected ? 1 : 0)
                .animation(.default, value: isSelected)
            Text(sound.rawValue.formatSoundName)
        }
    }
}

#Preview {
    SoundListView(selectedSound: .constant(Sounds.bird_forest))
}
