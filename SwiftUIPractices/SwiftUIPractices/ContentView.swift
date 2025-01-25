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
            TabView {
                Tab("Feature Demos", systemImage: "house") {
                    List {
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
                        NavigationLink(
                            "Gestures",
                            destination: GesturesExample()
                        )
                        NavigationLink(
                            "Text Styling",
                            destination: TextStylingExample()
                        )
                    }
                }
                Tab("User Interface Practices", systemImage: "person") {
                    List {
                        NavigationLink(
                            "Price Card",
                            destination: PriceCardPractice()
                        )
                        NavigationLink(
                            "Custom Color Picker",
                            destination: CustomColorPickerPractice()
                        )
                        NavigationLink(
                            "Progress Bar",
                            destination: ProgressBarPractice()
                        )
                        NavigationLink(
                            "Drag and Z-index",
                            destination: DragPractice()
                        )
                        NavigationLink(
                            "Segmented Border",
                            destination: SegmentedBorderPractice()
                        )
                        NavigationLink(
                            "Custom Tooltip",
                            destination: CustomToolTipPractice()
                        )
                        NavigationLink(
                            "Chocolate View",
                            destination: ChocolateViewPractice()
                        )
                        NavigationLink(
                            "Custom Label Style",
                            destination: CustomLabelStylePractice()
                        )
                        NavigationLink(
                            "TextField",
                            destination: TextFieldPractice()
                        )
                        NavigationLink(
                            "Toast",
                            destination: ToastPractice()
                        )
                    }
                }
            }.navigationTitle("SwiftUI Practices")
        }
    }
}

#Preview {
    ContentView()
}
