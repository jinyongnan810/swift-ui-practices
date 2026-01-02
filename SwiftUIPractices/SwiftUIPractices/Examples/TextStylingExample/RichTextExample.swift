//
//  RichTextExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/02.
//

import SwiftUI

struct RichTextExample: View {
    @State private var text = AttributedString("Hello, World!")
    @State private var selection = AttributedTextSelection()
    @State private var selectedFontTag: String = "default"
    @Environment(\.fontResolutionContext) private var fontResolutionContext

    private func label(forTag tag: String) -> String {
        switch tag {
        case "default": "Font"
        case "largeTitle": "Large Title"
        case "title": "Title"
        case "title2": "Title 2"
        case "headline": "Headline"
        case "subheadline": "Subheadline"
        default: "Custom"
        }
    }

    private func font(forTag tag: String) -> Font? {
        switch tag {
        case "largeTitle": .largeTitle
        case "title": .title
        case "title2": .title2
        case "headline": .headline
        case "subheadline": .subheadline
        default: nil
        }
    }

    private func updateSelectedFontTagFromSelection(selection: AttributedTextSelection) {
        let attrs = selection.typingAttributes(in: text)
        switch attrs.font {
        case .some(.largeTitle): selectedFontTag = "largeTitle"
        case .some(.title): selectedFontTag = "title"
        case .some(.title2): selectedFontTag = "title2"
        case .some(.headline): selectedFontTag = "headline"
        case .some(.subheadline): selectedFontTag = "subheadline"
        default: selectedFontTag = "default"
        }
    }

    var body: some View {
        VStack {
            TextEditor(text: $text, selection: $selection)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                }.padding()
        }
        .safeAreaInset(
            edge: .bottom,
            content: {
                VStack {
                    // Alignment and Font
                    HStack {
                        // Alignment
                        Button("", systemImage: "text.alignleft") {
                            text.transformAttributes(in: &selection) { container in
                                container.alignment = .left
                            }
                        }.buttonStyle(.glass)
                        Button("", systemImage: "text.aligncenter") {
                            text.transformAttributes(in: &selection) { container in
                                container.alignment = .center
                            }
                        }.buttonStyle(.glass)
                        Button("", systemImage: "text.alignright") {
                            text.transformAttributes(in: &selection) { container in
                                container.alignment = .right
                            }
                        }.buttonStyle(.glass)
                        // Fonts
                        Picker(label(forTag: selectedFontTag), selection: $selectedFontTag) {
                            Text("Font").tag("default")
                            Text("Large Title").tag("largeTitle")
                            Text("Title").tag("title")
                            Text("Title 2").tag("title2")
                            Text("Headline").tag("headline")
                            Text("Subheadline").tag("subheadline")
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedFontTag) { _, newValue in
                            let chosen = font(forTag: newValue)
                            text.transformAttributes(in: &selection) { container in
                                container.font = chosen
                            }
                        }.glassEffect()
                    }
                    .onChange(of: selection) { _, _ in
                        updateSelectedFontTagFromSelection(selection: selection)
                    }
                    .onChange(of: text) { _, _ in
                        updateSelectedFontTagFromSelection(selection: selection)
                    }
                    // Styling
                    HStack {
                        // Underline and StrikeThrough
                        Button("", systemImage: "underline") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.underlineStyle
                                container.underlineStyle = (current == .single) ? nil : .single
                            }
                        }.buttonStyle(.glass)
                        Button("", systemImage: "strikethrough") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.strikethroughStyle
                                container.strikethroughStyle = (
                                    current == .single
                                ) ? nil : .single
                            }
                        }.buttonStyle(.glass)
                        // Baseline
                        Button("", systemImage: "arrow.up") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.baselineOffset
                                container.baselineOffset = (current ?? 0) + 1
                            }
                        }.buttonStyle(.glass)
                        Button("", systemImage: "arrow.down") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.baselineOffset
                                container.baselineOffset = (current ?? 0) - 1
                            }
                        }.buttonStyle(.glass)
                        // Bold and Italic
                        Button("", systemImage: "bold") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.font ?? .default
                                let resolved = current.resolve(
                                    in: fontResolutionContext
                                )
                                let isBold = resolved.isBold
                                container.font = current.bold(!isBold)
                            }
                        }.buttonStyle(.glass)
                        Button("", systemImage: "italic") {
                            text.transformAttributes(in: &selection) { container in
                                let current = container.font ?? .default
                                let resolved = current.resolve(
                                    in: fontResolutionContext
                                )
                                let isItalic = resolved.isItalic
                                container.font = current.italic(!isItalic)
                            }
                        }.buttonStyle(.glass)
                    }
                    // Colors
                    ColorPickerView { color in
                        text.transformAttributes(in: &selection) { container in
                            container.foregroundColor = color
                        }
                    }
                }
            }
        )
        .onAppear {
            updateSelectedFontTagFromSelection(selection: selection)
        }
    }
}

struct ColorPickerView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .cyan, .pink]
    let onColorPicked: (Color) -> Void
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(.gray.opacity(0.5))
                    }.onTapGesture {
                        onColorPicked(color)
                    }
            }
        }
    }
}

#Preview {
    RichTextExample()
}
