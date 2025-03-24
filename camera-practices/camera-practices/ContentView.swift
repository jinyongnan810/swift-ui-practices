//
//  ContentView.swift
//  camera-practices
//
//  Created by Yuunan kin on 2025/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var frameHandler = FrameHandler()
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
