//
//  FlipCardPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/03/20.
//

import SwiftUI

struct FlipCardPractice: View {
    @State private var isFlipped = false
    var sideAZIndex: Double { isFlipped ? 1 : 2 }
    var sideBZIndex: Double { isFlipped ? 2 : 1 }
    var body: some View {
        ZStack {
            SideA()
                .zIndex(sideAZIndex)
            SideB()
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .zIndex(sideBZIndex)
        }.frame(width: 300, height: 400)
            .clipShape(.rect(cornerRadius: 12))
            .shadow(radius: 5)
            .rotation3DEffect(.degrees(isFlipped ? 180: 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
//                withAnimation(.spring(duration: 2)) {
                withAnimation {
                    isFlipped.toggle()
                }
            }
    }
}

struct SideA: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.cyan, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Text("Side A")
        }
    }
}

struct SideB: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.orange, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Text("Side B")
        }
    }
}

#Preview {
    FlipCardPractice()
}
