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
                            let opacity = 1 - abs(value)

                            return content
                                .opacity(opacity)
                        }
                }
            }
        }
    }
}

#Preview {
    ScrollTransitionExample()
}
