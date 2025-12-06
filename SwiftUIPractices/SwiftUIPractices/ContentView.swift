//
//  ContentView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

enum Page: Hashable {
    case navigation
    case customViewModifier
    case meshGradient
    case scrollTransition
    case tabView
    case effects
    case observation
    case image
    case animation
    case shape
    case gestures
    case textStyling
    case clock
    case swipeActions
    case flipCard
    case sheetWithHeight
    case priceCard
    case customColorPicker
    case progressBar
    case drag
    case segmentedBorder
    case customTooltip
    case chocolateView
    case customLabelStyle
    case textField
    case toast
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Feature Demos", systemImage: "house") {
                    List {
                        NavigationLink("Navigation", value: Page.navigation)
                        NavigationLink("View Modifier", value: Page.customViewModifier)
                        NavigationLink("Mesh Gradient & Timer & Animation", value: Page.meshGradient)
                        NavigationLink("Scroll Transition", value: Page.scrollTransition)
                        NavigationLink("TabView", value: Page.tabView)
                        NavigationLink("Effects", value: Page.effects)
                        NavigationLink("Observation", value: Page.observation)
                        NavigationLink("Image", value: Page.image)
                        NavigationLink("Animations", value: Page.animation)
                        NavigationLink("Shape", value: Page.shape)
                        NavigationLink("Gestures", value: Page.gestures)
                        NavigationLink("Text Styling", value: Page.textStyling)
                    }
                }
                Tab("User Interface Practices", systemImage: "person") {
                    List {
                        NavigationLink("Clock", value: Page.clock)
                        NavigationLink("List with Swipe Actions", value: Page.swipeActions)
                        NavigationLink("Flipping Card", value: Page.flipCard)
                        NavigationLink("Sheet with specified height", value: Page.sheetWithHeight)
                        NavigationLink("Price Card", value: Page.priceCard)
                        NavigationLink("Custom Color Picker", value: Page.customColorPicker)
                        NavigationLink("Progress Bar", value: Page.progressBar)
                        NavigationLink("Drag and Z-index", value: Page.drag)
                        NavigationLink("Segmented Border", value: Page.segmentedBorder)
                        NavigationLink("Custom Tooltip", value: Page.customTooltip)
                        NavigationLink("Chocolate View", value: Page.chocolateView)
                        NavigationLink("Custom Label Style", value: Page.customLabelStyle)
                        NavigationLink("TextField", value: Page.textField)
                        NavigationLink("Toast", value: Page.toast)
                    }
                }
            }.navigationTitle("SwiftUI Practices")
                .navigationDestination(for: Page.self) { page in
                    switch page {
                    case .navigation:
                        NavigationExample()
                    case .customViewModifier:
                        CustomViewModifierExample()
                    case .meshGradient:
                        MeshGradientExample()
                    case .scrollTransition:
                        ScrollTransitionExample()
                    case .tabView:
                        TabViewExample()
                    case .effects:
                        EffectsExample()
                    case .observation:
                        ObservationExample()
                    case .image:
                        ImageExploreExample()
                    case .animation:
                        AnimationExample()
                    case .shape:
                        ShapeExample()
                    case .gestures:
                        GesturesExample()
                    case .textStyling:
                        TextStylingExample()
                    case .clock:
                        ClockView()
                    case .swipeActions:
                        SwipeActionsPractice()
                    case .flipCard:
                        FlipCardPractice()
                    case .sheetWithHeight:
                        SheetWithHeightPractice()
                    case .priceCard:
                        PriceCardPractice()
                    case .customColorPicker:
                        CustomColorPickerPractice()
                    case .progressBar:
                        ProgressBarPractice()
                    case .drag:
                        DragPractice()
                    case .segmentedBorder:
                        SegmentedBorderPractice()
                    case .customTooltip:
                        CustomToolTipPractice()
                    case .chocolateView:
                        ChocolateViewPractice()
                    case .customLabelStyle:
                        CustomLabelStylePractice()
                    case .textField:
                        TextFieldPractice()
                    case .toast:
                        ToastPractice()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
