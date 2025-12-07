//
//  PluralizationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct PluralizationExample: View {
    @State private var count = 0
    let nounList: [String] = ["bread", "salt", "domino", "radius", "child", "foot", "tooth", "man", "woman", "goose", "focus", "matrix", "deer", "oasis", "fish", "index", "boom", "brush"]

    var body: some View {
        VStack {
            List {
                ForEach(nounList, id: \.self) { noun in
                    LabeledContent(noun.capitalized) {
                        Text("^[\(count) \(noun.capitalized)](inflect: true)")
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            Button("Plus 1") {
                count += 1
            }.buttonStyle(.glassProminent).font(.title)
        })

        .toolbar {
            ToolbarItem {
                Button("reset") {
                    count = 0
                }.padding()
            }
        }
        .navigationTitle("Pluralization")
    }
}

#Preview {
    NavigationStack {
        PluralizationExample()
    }
}
