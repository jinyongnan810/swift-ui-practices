//
//  ContentView.swift
//  camera-practices
//
//  Created by Yuunan kin on 2025/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var frameHandler = FrameHandler()
    @State private var showControls: Bool = false
    var body: some View {
        ZStack {
            FrameView(image: frameHandler.frame)
                .ignoresSafeArea()
                .onChange(of: frameHandler.permissionGranted) { oldValue, newValue in
                    if !oldValue, newValue {
                        frameHandler.startCapturing()
                    }
                }
                .task {
                    if frameHandler.permissionGranted {
                        frameHandler.startCapturing()
                    }
                }
                .onTapGesture {
                    withAnimation {
                        showControls.toggle()
                    }
                }.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            Controls(frameHandler: $frameHandler)
                .opacity(showControls ? 1 : 0)
        }
    }
}

struct Controls: View {
    @Binding var frameHandler: FrameHandler
    var body: some View {
        HStack {
            ForEach(Mode.allCases, id: \.self) { mode in
                Button(action: {
                    withAnimation {
                        frameHandler.mode = mode
                    }
                }) {
                    Text(mode.rawValue)
                        .padding()
                        .background(mode == frameHandler.mode ? .black : .gray)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 12))
                        .overlay {
                            if mode == frameHandler.mode {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .fill(.white)
                            }
                        }
                }
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
