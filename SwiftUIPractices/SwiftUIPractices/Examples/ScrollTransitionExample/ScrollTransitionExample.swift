//
//  ScrollTransitionExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/14.
//

import SwiftUI

struct ScrollTransitionExample: View {
    

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(images, id: \.self) { image in
                    MyImageView(name: image)
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            // -1 ... 1
                            let value = phase.value

                            // 0 ... 1
//                            let opacity = cos((.pi/2) * value)
                            var opacity = 1 - abs(value)
                            opacity = phase.isIdentity ? 1 : opacity

                            return content
//                                .opacity(opacity)
//                                .scaleEffect(opacity)
//                                .offset(y: 100 * phase.value)
                                .offset(x: phase.value * -300)
                                .brightness(0.3 * abs(phase.value))
                        }
                        .clipShape(.rect(cornerRadius: 30))
                }
            }
        }
    }
}

#Preview {
    ScrollTransitionExample()
}
