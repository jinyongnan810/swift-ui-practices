//
//  NumberWithUnit.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct NumberWithUnit<Content: View>: View {
    let content: Content
    let unit: String

    init(@ViewBuilder content: () -> Content, unit: String = "lb") {
        self.content = content()
        self.unit = unit
    }

    var body: some View {
        HStack {
            content
            Text(unit)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(2)
        }
    }
}
