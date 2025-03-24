//
//  FrameView.swift
//  camera-practices
//
//  Created by Yuunan kin on 2025/03/24.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    var body: some View {
        if let image {
            Image(
                image,
                scale: 1.0,
                orientation: .up,
                label: Text("My Label")
            ).resizable()
                .scaledToFill()
        } else {
            VStack {
                Text("No Image")
                    .padding()
                Button(action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Check Settings")
                }
            }
        }
    }
}

#Preview {
    FrameView()
}
