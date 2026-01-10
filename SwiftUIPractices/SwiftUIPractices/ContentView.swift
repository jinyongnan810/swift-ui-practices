//
//  ContentView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

enum Page: String, Hashable {
    case navigation = "Navigation"
    case customViewModifier = "Custom View Modifier"
    case meshGradient = "Mesh Gradient"
    case scrollTransition = "Scroll Transition"
    case tabView = "TabView"
    case effects = "Effects"
    case observation = "Observation"
    case image = "Image"
    case animation = "Animation"
    case shape = "Shape"
    case gestures = "Gestures"
    case textStyling = "Text Styling"
    case clock = "Clock"
    case gauge = "Gauge"
    case swipeActions = "Swipe Actions"
    case flipCard = "Flip Card"
    case sheet = "Sheets"
    case priceCard = "Price Card"
    case customColorPicker = "Custom Color Picker"
    case progressBar = "Progress Bar"
    case drag = "Drag"
    case segmentedBorder = "Segmented Border"
    case customTooltip = "Custom Tooltip"
    case chocolateView = "Chocolate View"
    case customLabelStyle = "Custom Label Style"
    case textField = "Text Field"
    case toast = "Toast"
}

let featureDemos: [Page] = [
    .navigation,
    .customViewModifier,
    .meshGradient,
    .scrollTransition,
    .tabView,
    .effects,
    .observation,
    .image,
    .animation,
    .shape,
    .gestures,
    .textStyling,
]
let uiPractices: [Page] = [
    .clock,
    .gauge,
    .swipeActions,
    .flipCard,
    .sheet,
    .priceCard,
    .customColorPicker,
    .progressBar,
    .drag,
    .segmentedBorder,
    .customTooltip,
    .chocolateView,
    .customLabelStyle,
    .textField,
    .toast,
]
var allPages: [Page] { featureDemos + uiPractices }

struct PageTab: View {
    let pages: [Page]
    let title: String
    @State var searchQuery: String = ""
    @State private var path = NavigationPath()

    var filteredPages: [Page] {
        searchQuery.isEmpty ? pages : pages
            .filter { $0.rawValue.contains(searchQuery) == true }
    }

    var body: some View {
        NavigationStack(path: $path) {
            List(filteredPages, id: \.self) { page in
                NavigationLink(page.rawValue, value: page)
            }.searchable(text: $searchQuery, prompt: "Search...")
                .navigationTitle(Text(title))
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
                    case .gauge:
                        GaugePractice()
                    case .swipeActions:
                        SwipeActionsPractice()
                    case .flipCard:
                        FlipCardPractice()
                    case .sheet:
                        SheetPractices()
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
        }.onChange(of: path) { _, newValue in
            print("path: \(newValue)")
        }
    }
}

struct ContentView: View {
    @State private var searchQuery: String = ""
    var body: some View {
        TabView {
            Tab("Feature Demos", systemImage: "house") {
                PageTab(pages: featureDemos, title: "Feature Demos")
            }
            Tab("User Interface Practices", systemImage: "person") {
                PageTab(pages: uiPractices, title: "User Interface Practices")
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                PageTab(pages: allPages, title: "Search")
            }
        }
        .tabViewBottomAccessory(content: {
            Text("\(Image(systemName: "swift")) Made with SwiftUI")
        })
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewSearchActivation(.automatic)
        .tabViewStyle(.sidebarAdaptable)
//            .searchable(text: $searchQuery, prompt: "Search...")
//            .navigationTitle("SwiftUI Practices")
    }
}

#Preview {
    ContentView()
}
