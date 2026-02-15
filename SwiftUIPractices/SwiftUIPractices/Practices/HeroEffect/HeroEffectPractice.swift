//
//  HeroEffectPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/02/15.
//
//  Demonstrates a hero transition effect between a compact horizontal photo
//  gallery and a full-screen detail view. The animation uses `matchedGeometryEffect`
//  to seamlessly morph the tapped photo card from its thumbnail position into
//  an expanded detail layout, creating the classic "hero" transition pattern.
//
//  Architecture overview:
//  ┌──────────────────────────────────────────┐
//  │  HeroEffectPractice (root)               │
//  │  ├─ SimpleScrollView   (thumbnail strip) │
//  │  │   └─ SimpleView     (single card)     │
//  │  └─ DetailedScrollView (full-screen)     │
//  │      └─ DetailedView   (expanded card)   │
//  └──────────────────────────────────────────┘
//  Both layers exist in the same ZStack (via .overlay). Only one is visible
//  at a time, controlled by the `expanded` flag with opacity + hit-testing.
//

import SwiftUI

// MARK: - Data Model

/// A simple model representing a photo entry in the gallery.
/// Each photo has a unique ID (auto-generated), an asset name, and an author credit.
private struct Photo: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var author: String
}

/// Sample photo data referencing image assets bundled with the app.
private let photos: [Photo] = [
    .init(name: "imgLightening1", author: "Author1"),
    .init(name: "imgNature", author: "Author2"),
    .init(name: "imgPurpleLightening", author: "Author3"),
    .init(name: "imgRoad", author: "Author4"),
    .init(name: "imgSunset1", author: "Author5"),
    .init(name: "imgSunset2", author: "Author6"),
]

// MARK: - Main View

struct HeroEffectPractice: View {
    /// Spacing between photo cards in both the simple and detailed scroll views.
    let spacing: CGFloat = 20
    /// Fixed width for each thumbnail card in the compact gallery.
    let cardWidth: CGFloat = 200

    /// Whether the detail view is currently presented (expanded).
    @State private var expanded: Bool = false
    /// The index of the currently selected photo (drives which photo is shown in detail).
    @State private var selectedIndex: Int? = nil
    /// Tracks the index the user scrolled to in the detail view when dismissing,
    /// so the thumbnail strip can sync its scroll position accordingly.
    @State private var dismissedIndex: Int? = nil
    /// Shared namespace for `matchedGeometryEffect` — this is what connects
    /// the thumbnail image to the detail image and enables the hero morph animation.
    @Namespace private var heroNameSpace
    /// Programmatic scroll position for the thumbnail strip.
    @State private var scrollPosition: ScrollPosition = .init()

    var body: some View {
        VStack {
            // Compact horizontal gallery of photo thumbnails
            SimpleScrollView()

        }.safeAreaPadding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // The detail view is layered on top as an overlay.
            // Both views exist simultaneously; visibility is toggled via opacity.
            .overlay {
                DetailedScrollView()
                    .safeAreaPadding(20)
            }
    }

    // MARK: - Thumbnail Gallery (SimpleScrollView)

    /// Displays a horizontally scrolling strip of photo thumbnails.
    /// Tapping a card triggers the hero expansion animation.
    ///
    /// Key behaviors:
    /// - Hidden (opacity 0) when a photo is expanded to avoid visual overlap.
    /// - Hit testing disabled during expansion so taps pass through to the detail view.
    /// - Syncs scroll position when the user dismisses from a different photo
    ///   than the one they originally tapped (via `dismissedIndex`).
    @ViewBuilder
    func SimpleScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach(photos.indices, id: \.self) { index in
                        SimpleView(photoIndex: index)
                            // Register this view as the hero source/destination
                            // for the photo at this index. The same ID is used
                            // in DetailedView to create the morph animation.
                            .matchedGeometryEffect(
                                id: photos[index].id,
                                in: heroNameSpace,
                            )
                            .frame(
                                width: cardWidth,
                                height: geometry.size.height,
                            )
                            .clipShape(.rect(cornerRadius: 20))
                            .onTapGesture {
                                // Animate both the expansion flag and the selected
                                // index together so matchedGeometryEffect can
                                // interpolate between the two positions smoothly.
                                withAnimation(.bouncy(duration: 0.4)) {
                                    expanded = true
                                    selectedIndex = index
                                }
                            }
                    }
                }.padding(.horizontal, 20)
                    // Disable interaction on thumbnails while detail is shown
                    .allowsHitTesting(expanded == false)
            }.scrollPosition($scrollPosition)
                // When the user scrolls to a different photo in detail view
                // and then dismisses, update the thumbnail strip's scroll
                // position to match the photo they ended up on.
                .onChange(of: dismissedIndex) { oldValue, newValue in
                    guard let newValue, oldValue == nil else { return }
                    // Calculate the x offset for the target card
                    let offset = CGFloat(newValue) * (cardWidth + spacing)
                    scrollPosition.scrollTo(x: offset)
                    dismissedIndex = nil
                }
        }.frame(height: 250)
            // Fade out the thumbnail strip when expanded
            .opacity(expanded ? 0 : 1)
    }

    // MARK: - Thumbnail Card (SimpleView)

    /// Renders a single thumbnail card — just a fill-mode image.
    @ViewBuilder
    func SimpleView(photoIndex: Int) -> some View {
        let photo: Photo = photos[photoIndex]
        Image(photo.name)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }

    // MARK: - Detail Gallery (DetailedScrollView)

    /// A full-screen horizontally paged scroll view showing expanded photo details.
    ///
    /// Key implementation details:
    /// - Uses `defaultScrollAnchor` with a computed `anchorX` to initially scroll
    ///   to the selected photo without any visible jump.
    /// - `scrollTargetBehavior(.viewAligned)` enables page-snapping so the user
    ///   can swipe between photos in the detail view.
    /// - `onScrollPhaseChange` detects when scrolling settles on a new photo
    ///   and records its index in `dismissedIndex` so the thumbnail strip
    ///   can sync when the detail view is dismissed.
    @ViewBuilder
    func DetailedScrollView() -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            if let sourceIndex = selectedIndex, expanded {
                // Compute the normalized anchor position (0.0–1.0) so that
                // the scroll view initially centers on the selected photo.
                // Formula: (index * pageWidth) / (totalScrollableWidth)
                let anchorX = CGFloat(
                    CGFloat(sourceIndex) * size.width
                ) / (CGFloat(photos.count - 1) * size.width)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(photos.indices, id: \.self) { index in
                            // Use a clear Rectangle as the paging frame,
                            // then overlay the actual content. This ensures
                            // each page is exactly screen-width for snapping.
                            Rectangle()
                                .foregroundStyle(.clear)
                                .overlay {
                                    GeometryReader { geo in
                                        let innerSize = geo.size
                                        DetailedView(photoIndex: index)
                                            // Tap anywhere on the detail card to collapse
                                            .onTapGesture {
                                                withAnimation(.bouncy(duration: 0.4)) {
                                                    expanded = false
                                                    selectedIndex = nil
                                                }
                                            }.frame(
                                                width: innerSize.width,
                                                height: innerSize
                                                    .height,
                                                alignment: .top
                                            ).background(
                                                // Subtle border around the detail card
                                                RoundedRectangle(
                                                    cornerRadius: 30
                                                )
                                                .stroke(
                                                    .black,
                                                    style: .init(lineWidth: 1)
                                                )
                                            )
                                            .clipShape(.rect(cornerRadius: 30))
                                    }
                                }
                                .frame(
                                    width: size.width,
                                    height: size
                                        .height
                                )
                        }
                    }.scrollTargetLayout()
                }
                // Snap each page to center with view-aligned paging behavior
                .scrollTargetBehavior(
                    .viewAligned(limitBehavior: .alwaysByFew, anchor: .center)
                )
                // Start the scroll view at the selected photo's position
                .defaultScrollAnchor(.init(x: anchorX, y: 0.5), for: .initialOffset)
                // Allow content to render outside the scroll view's bounds
                // (needed for the hero transition to look seamless)
                .scrollClipDisabled()
                // Track which photo the user scrolls to, so when they dismiss,
                // the thumbnail strip scrolls to match.
                .onScrollPhaseChange { oldPhase, newPhase, context in
                    // Only act when scrolling comes to rest (transitions to .idle)
                    guard oldPhase != .idle, newPhase == .idle else { return }
                    let geo = context.geometry
                    // Calculate the current page index from the scroll offset
                    let offset = geo.contentOffset.x + geo.contentInsets.leading
                    let index = Int(round(offset / size.width))
                    // Only record if the user scrolled to a different photo
                    if index != selectedIndex {
                        dismissedIndex = index
                    }
                }
            }
        }
        // Fade in/out the detail view based on expansion state
        .opacity(expanded ? 1 : 0)
        // Only allow interaction when expanded
        .allowsHitTesting(expanded == true)
    }

    // MARK: - Detail Card (DetailedView)

    /// Renders a single expanded photo card with a vertically scrollable layout
    /// containing the full-size image, author credit, and placeholder description text.
    ///
    /// The `matchedGeometryEffect` on the Image here shares the same ID and namespace
    /// as the corresponding thumbnail in `SimpleView`, enabling SwiftUI to automatically
    /// animate the position, size, and shape transition between the two states.
    @ViewBuilder
    func DetailedView(photoIndex: Int) -> some View {
        let photo: Photo = photos[photoIndex]
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Image(photo.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 20))
                    // This is the counterpart of the matchedGeometryEffect
                    // in SimpleScrollView — same ID links both views for
                    // the hero morph animation.
                    .matchedGeometryEffect(
                        id: photo.id,
                        in: heroNameSpace,
                    )
                Text(photo.author)
                    .font(.callout)
                    .padding()
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            }.padding()
        }
    }
}

// MARK: - Preview

#Preview {
    HeroEffectPractice()
}
