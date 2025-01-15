//
//  BlurExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/15.
//

import SwiftUI

struct BlurExample: View {
    @State private var backgroundBlurRadius: Double = 30
    @State private var redBlurRadius: Double = 30
    @State private var blueBlurRadius: Double = 30
    @State private var blendModeIndex = 0
    let blendModes: [BlendMode] = [
        .normal,
        .plusLighter,
        .plusDarker,
        .softLight,
        .multiply,
        .screen,
        .overlay,
        .darken,
        .lighten,
    ]
    private var blendMode: BlendMode { blendModes[blendModeIndex] }

    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    colors: [.red, .green, .blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blur(radius: backgroundBlurRadius)
                .ignoresSafeArea()

                Rectangle()
                    .fill(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 30))
                    .padding()

                VStack {
                    Spacer()
                    Spacer()
                    Text("Blur, ultraThinMaterial, BlendMode")
                        .font(.largeTitle)
                        .padding()
                    Text("Current BlendMode: \(blendMode)")
                        .font(.headline)
                        .padding()
                    Spacer()
                    VStack {
                        TextSliderView(
                            title: "Background Blur Radius",
                            value: $backgroundBlurRadius,
                            min: 0,
                            max: 50
                        )
                        TextSliderView(
                            title: "Red Blur Radius",
                            value: $redBlurRadius,
                            min: 0,
                            max: 50
                        )
                        TextSliderView(
                            title: "Blue Blur Radius",
                            value: $blueBlurRadius,
                            min: 0,
                            max: 50
                        )
                    }.padding()
                }.padding()

                Circle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .offset(x: -50, y: 50)
                    .blur(radius: redBlurRadius)
                    .blendMode(blendMode)
                Circle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                    .offset(x: 50, y: -50)
                    .blur(radius: blueBlurRadius)
                    .blendMode(blendMode)
            }

        }.onTapGesture {
            blendModeIndex = (blendModeIndex + 1) % blendModes.count
        }
    }
}

#Preview {
    BlurExample()
}
