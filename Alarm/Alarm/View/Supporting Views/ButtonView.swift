//
//  ButtonView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//

import SwiftUI

struct ButtonView: View {
    let text: LocalizedStringKey
    var body: some View {
        Text(text)
            .foregroundStyle(.myBlack)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                MainGradient(endRadius: 40, scale: 3)
                    .clipShape(.rect(cornerRadius: 10))
            )
    }
}

#Preview {
    ButtonView(text: "My Button")
}
