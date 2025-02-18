//
//  SelectSoundButtonView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/18.
//

import SwiftUI

struct SelectSoundButtonView: View {
    @Binding var sound: Sounds
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Sound").font(.title)
            Text(sound.rawValue.formatSoundName)
                .font(.headline)
        }.foregroundStyle(.myBlack)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.myBlack, lineWidth: 2)
            )
    }
}

#Preview {
    SelectSoundButtonView(sound: .constant(Sounds.bird_forest))
}
