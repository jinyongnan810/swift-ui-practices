//
//  ClipImagePractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct ClipImagePractice: View {
    @State var isStarted: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.cyan, .pink]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea().opacity(0.3)
            Image(ImagesForExploreExample.imgNature.rawValue)
                .resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Text(isStarted ? "Pause" : "Start")
                        .foregroundStyle(.green)
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .clipShape(Capsule())
                }
                .onTapGesture {
                    withAnimation(.easeIn) {
                        isStarted.toggle()
                    }
                }
        }
    }
}

#Preview {
    ClipImagePractice()
}
