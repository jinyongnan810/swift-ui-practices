//
//  StringInterpolationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct LineOfPoetry: Identifiable {
    let id = UUID()
    let line: String

    var firstCharacter: String {
        if let firstCharacter = line.first {
            return String(firstCharacter)
        } else {
            return ""
        }
    }

    var remainingCharacters: String {
        String(line.dropFirst())
    }
}

struct StringInterpolationExample: View {
    let poem: [LineOfPoetry] = [
        .init(line: "Dancing in the moonlight, free,"),
        .init(line: "Reaching for the stars, we see."),
        .init(line: "Every wish, a whispered stream,"),
        .init(line: "Aiming high, in every scheme."),
        .init(line: "Moments woven with desire,"),
        .init(line: "Soaring dreams, higher and higher."),
    ]
    var body: some View {
        VStack {
            ForEach(poem) { line in
                formatPoemLine(line)
            }
        }
    }

    private func formatPoemLine(_ line: LineOfPoetry) -> some View {
        Text(
            "\(Text(line.firstCharacter).foregroundStyle(.blue).font(.title).fontWeight(.bold))\(line.remainingCharacters)"
        )
    }
}

#Preview {
    StringInterpolationExample()
}
