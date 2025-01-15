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
            Tab("Blur & Blend mode", systemImage: "photo") {
                BlurExample()
            }
        }.tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    EffectsExample()
}
