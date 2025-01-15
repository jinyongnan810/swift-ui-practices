//
//  CustomViewModifierExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/14.
//

import SwiftUI

struct CustomViewModifierExample: View {
    var body: some View {
        ZStack {
            Text("Top Left")
                .modifier(AlignViewModifier(alignment: .topLeading))
            Text("Top Center")
                .align(.top)
            Text("Top Right")
                .align(.topTrailing)
            Text("Center")
                .modifier(AlignViewModifier())
            Text("Center Left")
                .align(.leading)
            Text("Center Right")
                .align(.trailing)
            Text("Bottom Left")
                .align(.bottomLeading)
            Text("Bottom Center")
                .align(.bottom)
            Text("Bottom Right")
                .align(.bottomTrailing)
        }
    }
}

struct AlignViewModifier: ViewModifier {
    let alignment: Alignment
    init(alignment: Alignment = .center) {
        self.alignment = alignment
    }

    func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
    }
}

extension View {
    func align(_ alignment: Alignment) -> some View {
        modifier(AlignViewModifier(alignment: alignment))
    }
}

#Preview {
    CustomViewModifierExample()
}
