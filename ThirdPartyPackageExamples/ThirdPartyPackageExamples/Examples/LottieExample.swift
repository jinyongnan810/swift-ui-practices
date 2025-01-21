//
//  LottieExample.swift
//  ThirdPartyPackageExamples
//
//  Created by Yuunan kin on 2025/01/21.
//

import SwiftUI
import Lottie

struct LottieExample: View {
    @State var playbackMode: LottiePlaybackMode = .paused
    var body: some View {
        Form {
            Section("Auto play") {
                LottieView(animation: .named("Animation2025"))
                    .playing(loopMode: .loop)
                    .frame(width: 200, height: 200)
            }
            Section("Controlled Play") {
                LottieView(animation: .named("Animation2025"))
                    .playbackMode(playbackMode)
                    .animationDidFinish({ completed in
                        if completed {
                            self.playbackMode = .paused
                        }
                    })
                    .onTapGesture {
                        self.playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
                    }
                    .frame(width: 200, height: 200)

            }
        }
    }
}

#Preview {
    LottieExample()
}
