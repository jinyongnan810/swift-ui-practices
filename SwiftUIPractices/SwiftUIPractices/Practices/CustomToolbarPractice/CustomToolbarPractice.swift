//
//  CustomToolbarPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/23.
//  Learning from Kavsoft: https://youtu.be/_h5S15Umk0Y?si=_MS27iOqENq1aYB8
//
// Demonstrates a custom navigation toolbar that dynamically updates its title
// and subtitle as the user scrolls through content sections.
// Uses onGeometryChange to detect when each section header scrolls past a
// threshold, and shows a context-aware title in the toolbar.

import SwiftUI

struct CustomToolbarPractice: View {
    // The current toolbar title — changes based on which section is visible
    @State var title: String?
    // The current toolbar subtitle — tracks which event date is in view
    @State var subTitle: String?
    // Controls visibility of the primary action button (shown after Subscribe scrolls away)
    @State var showPrimary: Bool = false
    // Index into `events` for the currently-visible event section
    @State var subtitleIndex: Int?

    // Per-section scroll activation flags, used to compute the correct title
    @State private var isTopActive: Bool = false
    @State private var isHotActive: Bool = false
    @State private var isNearbyActive: Bool = false

    let events: [String] = ["2026-02-23", "2026-03-04", "2026-03-11"]
    let gray = Color.gray.opacity(0.4)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: - Top section (app header)

                Group {
                    Image(systemName: "swift")
                        .font(.largeTitle)
                        .padding()
                        .background(.orange)
                        .clipShape(.circle)
                        .foregroundStyle(.white)

                    Text("Swift/SwftUI")
                        .font(.title)
                        .fontWeight(.bold)
                        // When this title scrolls more than 30pt above the scroll view origin,
                        // mark the top section as active and update the toolbar title.
                        .onGeometryChange(for: Bool.self) { geo in
//                            let height = geo.size.height
//                            let offset = geo.frame(in: .global).minY
//                            return -offset > height
                            let offset = geo.frame(in: .scrollView).minY
                            return -offset > 30
                        } action: { newValue in
                            isTopActive = newValue
                            updateTitle()
                        }

                    Text(
                        "SwiftUIとは、Appleが開発した、アプリケーションのグラフィカルユーザインタフェース (GUI) を構築するための、宣言的UIフレームワークである。WWDC 2019で発表され[1]、Xcode 11以降で利用可能となった。"
                    )

                    // Subscribe button — when it scrolls out of view, reveal the
                    // primary toolbar action button as a shortcut replacement.
                    Button {} label: {
                        Text("Subscribe")
                    }.buttonBorderShape(.capsule)
                        .buttonStyle(.glassProminent)
                        .tint(.orange)
                        .buttonSizing(.flexible)
                        .frame(width: 150)
                        .onGeometryChange(for: Bool.self) { geo in
                            let offset = geo.frame(in: .scrollView).minY
                            return -offset > 30
                        } action: { newValue in
                            showPrimary = newValue
                        }

                }.padding(.vertical, 5)
                Divider()

                // MARK: - Hot Events section

                Group {
                    HStack {
                        Text("ホットイベント")
                            .font(.title2)
                            .fontWeight(.bold)
                            // Activate "hot events" toolbar title when header scrolls past threshold
                            .onGeometryChange(for: Bool.self) { geo in
                                let offset = geo.frame(in: .scrollView).minY
                                return -offset > 30
                            } action: { newValue in
                                isHotActive = newValue
                                updateTitle()
                            }
                        Image(systemName: "chevron.right")
                    }
                    // Placeholder banner image
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 200)
                        .foregroundStyle(gray)
                }.padding(.vertical, 5)
                Divider()

                // MARK: - Nearby Events section

                Group {
                    HStack {
                        Text("近くのイベント")
                            .font(.title2)
                            .fontWeight(.bold)
                            // Activate "nearby events" toolbar title when header scrolls past threshold
                            .onGeometryChange(for: Bool.self) { geo in
                                let offset = geo.frame(in: .scrollView).minY
                                return -offset > 30
                            } action: { newValue in
                                isNearbyActive = newValue
                                updateTitle()
                            }
                        Image(systemName: "chevron.right")
                    }
                    // Each event gets its own section; the subtitle tracks which one is visible
                    ForEach(events.indices, id: \.self) { index in
                        eventView(index: index)
                    }

                }.padding(.vertical, 5)
            }.padding()
        }.modifier(CustomToolbarViewModifier(primaryVisible: showPrimary, title: title, subTitle: subTitle, leading: {
            EmptyView()
        }, trailing: {
            HStack {
                Button("search", systemImage: "magnifyingglass") {}
                Button("options", systemImage: "ellipsis") {}
            }
        }, primary: {
            // Floating primary action — appears in toolbar once Subscribe is off-screen
            Button("plus", systemImage: "plus") {}.buttonStyle(.glassProminent).tint(.orange)
        }))
        // Keep subTitle in sync with whichever event index is currently active
        .onChange(of: subtitleIndex) { _, new in
            if let new {
                subTitle = events[new]
            } else {
                subTitle = nil
            }
        }
    }

    // Determines the toolbar title based on which section has scrolled past the threshold.
    // Priority: nearby events > hot events > top-level header > nil (no title)
    private func updateTitle() {
        if isNearbyActive {
            title = "近くのイベント"
        } else if isHotActive {
            title = "ホットイベント"
        } else if isTopActive {
            title = "SwiftUI"
        } else {
            title = nil
        }
    }

    // Renders a single event section identified by its index in `events`.
    // Tracks scroll position so the toolbar subtitle shows the active event date.
    @ViewBuilder
    func eventView(index: Int) -> some View {
        let title = events[index]
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                // When this event's date label scrolls past the threshold, update subtitleIndex.
                // On scroll back, revert to the previous event index (or nil if at the top).
                .onGeometryChange(for: Bool.self) { geo in
                    let offset = geo.frame(in: .scrollView).minY
                    return -offset > 30
                } action: { newValue in
                    let perviousIndex = index - 1
                    subtitleIndex = newValue ? index : (perviousIndex < 0 ? nil : perviousIndex)
                }
            // Dummy content rows to make the section tall enough to scroll through
            dummyBlock()
            Divider()
            dummyBlock()
            Divider()
            dummyBlock()
            Divider()
            dummyBlock()
            Divider()
            dummyBlock()
            Divider()
            dummyBlock()
            Divider()
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 200)
                .foregroundStyle(gray)
            Divider()
        }
    }

    // A skeleton/placeholder card used as dummy content to fill event sections.
    // Mimics a thumbnail + text layout using gray rounded rectangles.
    @ViewBuilder
    func dummyBlock() -> some View {
        HStack(alignment: .center) {
            // Thumbnail placeholder
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 100)
                .foregroundStyle(gray)
            VStack(alignment: .leading) {
                // Title line placeholder
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 170, height: 30)
                    .foregroundStyle(gray)
                // Subtitle line placeholders
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 140, height: 20)
                    .foregroundStyle(gray)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 160, height: 20)
                    .foregroundStyle(gray)
            }
        }
    }
}

// A ViewModifier that injects a fully custom toolbar into any view.
// Supports leading/trailing items, an animated inline title+subtitle, and a
// conditionally-shown primary action button.
private struct CustomToolbarViewModifier<Leading: View, Trailing: View, Primary: View>: ViewModifier {
    var primaryVisible: Bool = false
    var title: String?
    var subTitle: String?
    @ViewBuilder var leading: Leading
    @ViewBuilder var trailing: Trailing
    @ViewBuilder var primary: Primary

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                leading
            }

            // Title area: uses a wide invisible spacer string so the overlay can
            // left-align content across the full toolbar title region.
            ToolbarItem(placement: .title) {
                Text(emptyLargeString)
                    .lineLimit(1)
                    .overlay(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 2) {
                            // Primary title — slides up and fades in/out with a blurReplace transition
                            if let title {
                                Text(title)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .transition(
                                        .offset(y: 10)
                                            .combined(
                                                with: AnyTransition(.blurReplace)
                                            )
                                    )
                            }
                            // Subtitle — fades in/out with a blurReplace transition
                            if let subTitle {
                                Text(subTitle)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.gray.opacity(0.5))
                                    .transition(.blurReplace)
                            }
                        }
                        .animation(.easeInOut, value: title)
                        .animation(.easeInOut, value: subTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }

            ToolbarItem(placement: .topBarTrailing) {
                trailing
            }

            // Primary action only rendered when its visibility flag is true;
            // the .animation(.bouncy) on the ScrollView animates it in/out.
            if primaryVisible {
                ToolbarItem(placement: .primaryAction) {
                    primary
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        // Bouncy animation for the primary action button appearing/disappearing
        .animation(.bouncy, value: primaryVisible)
    }

    // A 100-space string that acts as an invisible wide anchor for the title overlay,
    // ensuring the overlay can span the full width of the toolbar title slot.
    private var emptyLargeString: String {
        .init(repeating: " ", count: 100)
    }
}

#Preview {
    NavigationStack {
        CustomToolbarPractice()
    }
}
