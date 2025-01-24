//
//  DragBlock.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/23.
//

import SwiftUI

struct DragBlock: View {
    @Binding var data: DragBlockData
    @State var dragAmount: CGSize = .zero
    @State var isTapping: Bool = false

    var isDragging: Bool {
        dragAmount != .zero
    }

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragAmount = value.translation
                data = .init(image: data.image, color: data.color, zIndex: 1)
            }
            .onEnded { _ in
                withAnimation {
                    dragAmount = .zero
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        data = .init(image: data.image, color: data.color, zIndex: 0)
                    }
                }
            }
    }

    var body: some View {
        Image(systemName: data.image)
            .imageScale(.large)
            .padding()
            .foregroundStyle(data.color)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black.gradient)
                    if isTapping {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(data.color, lineWidth: 3)
                            .blur(radius: 5)
                    }
                }
            )
            .zIndex(data.zIndex)
            .opacity(isDragging ? 0.9 : 1)
            .scaleEffect(isDragging ? 1.2 : 1)
            .offset(dragAmount)
            .scaleEffect(isTapping ? 1.1 : 1)
            .animation(.spring, value: isTapping)
            .gesture(dragGesture)
            .onTapGesture {
                isTapping = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    data = .init(image: data.image)
                    isTapping = false
                }
            }
    }
}

#Preview {
    DragBlock(data: .constant(.init(image: "star", color: .blue, zIndex: 0)))
}
