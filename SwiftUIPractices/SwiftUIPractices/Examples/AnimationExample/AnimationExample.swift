//
//  AnimationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/19.
//

import SwiftUI

struct AnimationExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(
                    "SF Symbol Animations",
                    destination: SFSymbolsAnimation()
                )
                NavigationLink(
                    "Phase Animation",
                    destination: PhaseAnimationExample()
                )
            }
        }
    }
}

#Preview {
    AnimationExample()
}
