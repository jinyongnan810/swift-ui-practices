//
//  EffectsExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

struct EffectsExample: View {
    var body: some View {
        TabView {
            Tab("Ripple Effect", systemImage: "drop") {
                RipperEffectExample()
            }
            
            Tab("Blur & Blend mode", systemImage: "photo") {
                BlurExample()
            }

            Tab("Text with gradient", systemImage: "text.bubble") {
                TextWithGradientExample()
            }
        }.tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    EffectsExample()
}
