//
//  TextStylingExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct TextStylingExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("String Interpolation") {
                    StringInterpolationExample()
                }
                NavigationLink("Markdown") {
                    MarkdownExample()
                }
                NavigationLink("Pluralization") {
                    PluralizationExample()
                }
                NavigationLink("List Member styling & Measurement") {
                    ListMemberStyleExample()
                }
                NavigationLink("Date") {
                    DateTextExample()
                }
                NavigationLink("Attributed String") {
                    AttributedStringExample()
                }
            }
        }
    }
}

#Preview {
    TextStylingExample()
}
