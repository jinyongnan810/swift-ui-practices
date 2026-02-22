//
//  ContentView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

// MARK: - Page Enum

/// Defines all available demo pages in the app.
/// Each case has a raw value used as the display title in navigation.
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
    case dynamicIsland = "Dynamic Island"
    case infiniteCalendar = "Infinite Calendar"
    case complex3DAnimation = "Complex 3D Animation"
    case heroEffect = "Hero Effect"
    case screenshotPrevent = "Screenshot Prevent"
    case onboardingView = "Onboarding View"
}

// MARK: - Page Collections

/// Collection of pages demonstrating core SwiftUI features and APIs
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
    .dynamicIsland,
]

/// Collection of pages showcasing practical UI component implementations
let uiPractices: [Page] = [
    .onboardingView,
    .screenshotPrevent,
    .heroEffect,
    .complex3DAnimation,
    .infiniteCalendar,
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

/// Combined list of all pages for the search tab
var allPages: [Page] { featureDemos + uiPractices }

// MARK: - PageTab View

/// A reusable view that displays a searchable, navigable list of demo pages.
/// Used as the content for each tab in the main TabView.
struct PageTab: View {
    let pages: [Page]
    let title: String
    @State var searchQuery: String = ""
    @State private var path = NavigationPath()

    /// Filters pages based on the current search query
    var filteredPages: [Page] {
        searchQuery.isEmpty ? pages : pages
            .filter { $0.rawValue.contains(searchQuery) == true }
    }

    var body: some View {
        // NavigationStack enables programmatic navigation with path tracking
        NavigationStack(path: $path) {
            List(filteredPages, id: \.self) { page in
                NavigationLink(page.rawValue, value: page)
            }.searchable(text: $searchQuery, prompt: "Search...")
                .navigationTitle(Text(title))
                // Maps each Page enum case to its corresponding demo view
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
                    case .dynamicIsland:
                        DynamicIslandExample()
                    case .infiniteCalendar:
                        InfiniteCalendar()
                    case .complex3DAnimation:
                        Complex3DAnimation()
                    case .heroEffect:
                        HeroEffectPractice()
                    case .screenshotPrevent:
                        PreventScreenshotPractice()
                    case .onboardingView:
                        OnboardingPractice()
                    }
                }
        }.onChange(of: path) { _, newValue in
            print("path: \(newValue)")
        }
    }
}

// MARK: - ContentView

/// The main entry view of the app displaying a TabView with categorized demo pages.
/// Features an adaptive sidebar style and a bottom accessory with animated readme popup.
struct ContentView: View {
    /// Namespace for matched geometry effect during readme transition
    @Namespace private var readmeAnimation
    @State private var searchQuery: String = ""
    @State private var extendReadme: Bool = false

    var body: some View {
        TabView {
            // Tab for core SwiftUI feature demonstrations
            Tab("Feature Demos", systemImage: "house") {
                PageTab(pages: featureDemos, title: "Feature Demos")
            }
            // Tab for practical UI component examples
            Tab("User Interface Practices", systemImage: "person") {
                PageTab(pages: uiPractices, title: "User Interface Practices")
            }
            // Search tab that includes all pages from both categories
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                PageTab(pages: allPages, title: "Search")
            }
        }
        // Bottom accessory shows "Made with SwiftUI" branding
        .tabViewBottomAccessory(content: {
            Text("\(Image(systemName: "swift")) Made with SwiftUI")
                .onTapGesture {
                    extendReadme.toggle()
                }.matchedTransitionSource(id: "readme", in: readmeAnimation)
        })
        .tabBarMinimizeBehavior(.onScrollDown) // Minimizes tab bar when scrolling down
        .tabViewSearchActivation(.automatic) // Automatically activates search tab
        .tabViewStyle(.sidebarAdaptable) // Adapts between sidebar and tab bar based on platform
        // Full screen readme popup with zoom transition animation
        .fullScreenCover(isPresented: $extendReadme) {
            ScrollView {
                Text("\(Image(systemName: "swift")) Made with SwiftUI")
                    .padding()
                Text("If you interested in the full readme, you can check it out on [GitHub Repo](https://github.com/jinyongnan810/swift-ui-practices)!")
                    .padding()
            }.safeAreaInset(edge: .top) {
                Capsule().fill(.secondary).frame(width: 35, height: 3)
                    .navigationTransition(
                        .zoom(sourceID: "readme", in: readmeAnimation)
                    )
            }
            .background(.background)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
