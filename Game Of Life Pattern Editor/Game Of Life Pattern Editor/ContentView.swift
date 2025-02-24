//
//  ContentView.swift
//  Game Of Life Pattern Editor
//
//  Created by Yuunan kin on 2025/02/24.
//

import SwiftUI

let DotSize = 19

struct ContentView: View {
    @State private var name: String = "block"
    @State private var dots: [[Bool]] = Array(
        repeating: Array(repeating: false, count: DotSize),
        count: DotSize
    )
    var body: some View {
        HStack {
            EditorView(name: $name, dots: $dots)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ResultView(name: $name, dots: $dots)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(minWidth: 800, minHeight: 600)
    }
}

struct EditorView: View {
    @Binding var name: String
    @Binding var dots: [[Bool]]
    var body: some View {
        VStack {
            NameView(name: $name, dots: $dots)
            Spacer()
            DotsView(dots: $dots)
            Spacer()
        }
        .padding()
    }
}

struct NameView: View {
    @Binding var name: String
    @Binding var dots: [[Bool]]
    var body: some View {
        HStack {
            Text("Design Type:")
            TextField("Name", text: $name)
            Spacer()
            Button(action: {
                withAnimation {
                    dots = Array(
                        repeating: Array(repeating: false, count: DotSize),
                        count: DotSize
                    )
                    name = ""
                }
            }) {
                Text("Clear")
            }
        }
    }
}

struct DotsView: View {
    @Binding var dots: [[Bool]]
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0 ..< dots.count, id: \.self) { i in
                GridRow {
                    ForEach(0 ..< dots[i].count, id: \.self) { j in
                        Rectangle()
                            .fill(dots[i][j] ? Color.blue : Color.white)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                dots[i][j].toggle()
                            }
                    }
                }
            }
        }
    }
}

struct ResultView: View {
    @Binding var name: String
    @Binding var dots: [[Bool]]

    var result: String {
        """
        case .\(name):
            return \(activatedDots)
        """
    }

    var center = DotSize / 2

    var activatedDots: [(Int, Int)] {
        var activated: [(x: Int, y: Int)] = []
        for i in 0 ..< dots.count {
            for j in 0 ..< dots[i].count {
                if dots[i][j] {
                    activated.append((i - center, j - center))
                }
            }
        }
        return activated
    }

    var body: some View {
        ScrollView {
            HStack {
                Text(result)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .clipShape(.rect(cornerRadius: 12))
        .padding()
        .onDrag {
            NSItemProvider(object: result as NSItemProviderWriting)
        }
    }
}

#Preview {
    ContentView()
}
