//
//  TextAttributeAndRendererExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/21.
//

import SwiftUI

struct TextAttributeAndRendererExample: View {
    @State private var blur: Double = 3
    let heart = Image(systemName: "heart.fill")
    var helloWorld: Text {
        Text("Hello \(heart) World!").foregroundStyle(.orange)
            .customAttribute(MyCustomAttribute())
    }

    var body: some View {
        VStack {
            Spacer()
            Text(
                "Some text \"\(helloWorld)\" to test TextAttributes and TextRenderer."
            )
            .textRenderer(MyTextRenderer(blur: blur))
            .multilineTextAlignment(.center)
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                Text("Blur Radius: \(blur, specifier: "%.1f")")
                Slider(value: $blur, in: 0 ... 10) {
                    Label("Blur", systemImage: "sun.max")
                }
            }

        }.padding()
    }
}

struct MyTextRenderer: TextRenderer {
    let blur: Double
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let lines = layout.flatMap(\.self)
        for line in lines {
            print("⭐️ line: \(line.characterIndices), has custom attribute: \(line[MyCustomAttribute.self] != nil)")
            if line[MyCustomAttribute.self] != nil {
                var localContext = ctx
                let blurFilter = GraphicsContext.Filter.blur(radius: blur)
                localContext.addFilter(blurFilter)
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
