//
//  DragGestureExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/20.
//

import SwiftUI

struct DragGestureExample: View {
    @State private var offsetCurrent: CGSize = .zero
    @State private var offsetEnded: CGSize = .zero
    var offset1: CGSize {
        CGSize(
            width: offsetEnded.width + offsetCurrent.width,
            height: offsetEnded.height + offsetCurrent.height
        )
    }

    @State private var offset2: CGSize = .zero

    @Binding var storedOffsetEnded: CGSize
    @State private var offsetCurrent3: CGSize = .zero
    var offset3: CGSize {
        CGSize(
            width: storedOffsetEnded.width + offsetCurrent3.width,
            height: storedOffsetEnded.height + offsetCurrent3.height
        )
    }

    var body: some View {
        VStack {
            Spacer()
            MyTextView(text: "Stay Still")
                .offset(offset1)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offsetCurrent = value.translation
                        }
                        .onEnded { _ in
                            offsetEnded = offset1
                            offsetCurrent = .zero
                        }
                )
                .onTapGesture {
                    withAnimation {
                        offsetEnded = .zero
                        offsetCurrent = .zero
                    }
                }
            Spacer()
            MyTextView(text: "Bounce Back")
                .offset(offset2)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset2 = value.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                offset2 = .zero
                            }
                        }
                )

            Spacer()

            MyTextView(text: "Stored State")
                .offset(offset3)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offsetCurrent3 = value.translation
                        }
                        .onEnded { _ in
                            storedOffsetEnded = offset3
                            offsetCurrent3 = .zero
                        }
                )
                .onTapGesture {
                    withAnimation {
                        storedOffsetEnded = .zero
                        offsetCurrent3 = .zero
                    }
                }
            Spacer()
        }.navigationTitle("Drag")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DragGestureExample(storedOffsetEnded: .constant(.zero))
}
