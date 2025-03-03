//
//  NumberWithUnit.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct NumberWithUnit<Content: View>: View {
    let content: Content
    let unit: String = "lb"

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
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
