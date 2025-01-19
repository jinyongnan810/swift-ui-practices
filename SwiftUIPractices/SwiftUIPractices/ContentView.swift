//
//  ContentView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Feature Demos")) {
                    NavigationLink("Navigation", destination: NameAndAgeInputView())
                    NavigationLink("View Modifier", destination: CustomViewModifierExample())
                    NavigationLink("Mesh Gradient & Timer & Animation", destination: MeshGradientExample())
                    NavigationLink(
                        "Scroll Transition",
                        destination: ScrollTransitionExample()
                    )
                    NavigationLink(
                        "TabView",
                        destination: TabViewExample()
                    )
                    NavigationLink(
                        "Effects",
                        destination: EffectsExample()
                    )
                    NavigationLink(
                        "Observation",
                        destination: ObservationExample()
                    )
                    NavigationLink(
                        "Image",
                        destination: ImageExploreExample()
                    )
                    NavigationLink(
                        "Animations",
                        destination: AnimationExample()
                    )
                }
                Section(header: Text("User Interface Practices")) {
                    NavigationLink(
                        "Price Card",
                        destination: PriceCardPractice()
                    )
                    NavigationLink(
                        "Custom Color Picker",
                        destination: CustomColorPickerPractice()
                    )
                }
            }.navigationTitle("SwiftUI Practices")
        }
    }
}

#Preview {
    ContentView()
}
