//
//  TextAttributeAndRendererExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/21.
//

import SwiftUI

enum RenderType: String, CaseIterable {
    case blur
    case wobble
}

struct TextAttributeAndRendererExample: View {
    @State private var value: Double = 3
    @State private var type: RenderType = .blur
    let heart = Image(systemName: "heart.fill")
    var helloWorld: Text {
        Text("Hello \(heart) World!").foregroundStyle(.orange)
            .customAttribute(MyCustomAttribute())
    }

    var body: some View {
        VStack {
            Picker("Render Type", selection: $type) {
                ForEach(RenderType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
            Text(
                "Some text \"\(helloWorld)\" to test TextAttributes and TextRenderer."
            )
            .textRenderer(MyTextRenderer(value: value, type: type))
            .multilineTextAlignment(.center)
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                let label = type == .blur ? "Blur Radius" : "Wobbleness"
                Text("\(label): \(value, specifier: "%.1f")")
                Slider(value: $value, in: 0 ... 10) {
                    Label("Value", systemImage: "sun.max")
                }
            }

        }.padding()
    }
}

struct MyTextRenderer: TextRenderer {
    let value: Double
    let type: RenderType
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let lines = layout.flatMap(\.self)
        for line in lines {
            print("⭐️ line: \(line.characterIndices), has custom attribute: \(line[MyCustomAttribute.self] != nil)")
            if line[MyCustomAttribute.self] != nil {
                var localContext = ctx
                if type == .wobble {
                    let wobbleFilter = GraphicsContext.Filter.distortionShader(
                        ShaderLibrary.wobble(.float(value)),
                        maxSampleOffset: .zero
                    )
                    localContext.addFilter(wobbleFilter)
                } else {
                    let blurFilter = GraphicsContext.Filter.blur(radius: value)
                    localContext.addFilter(blurFilter)
                }

                localContext.draw(line)
            } else {
                let localContext = ctx
                localContext.draw(line)
            }
        }
    }
}

struct MyCustomAttribute: TextAttribute {}

#Preview {
    TextAttributeAndRendererExample()
}
