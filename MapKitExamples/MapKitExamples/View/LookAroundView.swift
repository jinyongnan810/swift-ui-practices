//
//  LookAroundView.swift
//  MapKitExamples
//
//  Created by Yuunan kin on 2025/02/07.
//

import MapKit
import SwiftUI

struct LookAroundView: View {
    @State private var scene: MKLookAroundScene?
    var body: some View {
        ZStack {
            if let scene {
                LookAroundPreview(initialScene: scene)
            } else {
                Text("Loading...")
            }
        }.task {
            await getScene()
        }
    }

    func getScene() async {
        scene = nil
        let request = MKLookAroundSceneRequest(
            coordinate: MyLocation.appleHeadquarters.coordinate
        )
        if let scene = try? await request.scene {
            self.scene = scene
        }
    }
}

#Preview {
    LookAroundView()
}
