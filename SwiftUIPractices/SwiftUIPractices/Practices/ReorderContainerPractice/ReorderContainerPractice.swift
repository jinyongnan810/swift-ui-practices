//
//  ReorderContainerPractice.swift
//  SwiftUIPractices
//
//  Created by Codex on 2026/06/10.
//

import SwiftUI

struct ReorderContainerPractice: View {
    var body: some View {
        Group {
            if #available(iOS 27.0, *) {
                // The actual reorder APIs are iOS 27+, so keep the demo isolated
                // behind an availability gate while still allowing the app to build
                // against the project's lower deployment target.
                ReorderContainerDemo()
            } else {
                ContentUnavailableView {
                    Label("Requires iOS 27", systemImage: "arrow.triangle.2.circlepath")
                } description: {
                    Text("`reorderContainer` and `reorderable(collectionID:)` are available starting in iOS 27.")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationTitle("Reorder Container")
    }
}

@available(iOS 27.0, *)
private enum ReorderLaneID: String, CaseIterable, Hashable, Sendable {
    case now = "Now Playing"
    case next = "Up Next"
}

@available(iOS 27.0, *)
private struct ReorderCard: Identifiable, Hashable, Sendable {
    enum Accent: String, Sendable {
        case coral
        case sky
        case lime
        case gold
        case pink
        case teal

        var primary: Color {
            switch self {
            case .coral:
                Color(red: 0.96, green: 0.42, blue: 0.35)
            case .sky:
                Color(red: 0.29, green: 0.62, blue: 0.97)
            case .lime:
                Color(red: 0.51, green: 0.80, blue: 0.34)
            case .gold:
                Color(red: 0.95, green: 0.73, blue: 0.27)
            case .pink:
                Color(red: 0.88, green: 0.41, blue: 0.67)
            case .teal:
                Color(red: 0.24, green: 0.76, blue: 0.72)
            }
        }
    }

    let id = UUID()
    let title: String
    let detail: String
    let systemImage: String
    let accent: Accent
}

@available(iOS 27.0, *)
private struct ReorderLane: Identifiable, Hashable, Sendable {
    let id: ReorderLaneID
    let description: String
    var cards: [ReorderCard]
}

@available(iOS 27.0, *)
private struct ReorderContainerDemo: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var lanes = Self.initialLanes

    private var isCompactWidth: Bool {
        horizontalSizeClass == .compact
    }

    private var isPreview: Bool {
        // SwiftUI previews are currently unstable when long-pressing into an active
        // reorder session, so the demo disables the gesture only in the canvas.
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    private var primaryTextColor: Color {
        colorScheme == .dark ? Color.white : Color.black.opacity(0.88)
    }

    private var secondaryTextColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.72) : Color.black.opacity(0.58)
    }

    private var laneSurfaceColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.58)
    }

    private var cardSurfaceColor: Color {
        colorScheme == .dark ? Color(red: 0.17, green: 0.18, blue: 0.22) : Color.white.opacity(0.9)
    }

    private var headerSurfaceColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.07) : Color.white.opacity(0.52)
    }

    private var resetButtonTint: Color {
        colorScheme == .dark ? Color.white.opacity(0.92) : Color.black.opacity(0.82)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                laneGrid
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundGradient)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Reorder cards inside a lane or move them across lanes.")
                .font(.headline)
                .foregroundStyle(secondaryTextColor)

            Group {
                if isCompactWidth {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Long press and drag", systemImage: "hand.draw")
                        Label("Move cards across both groups", systemImage: "square.split.2x1")
                    }
                } else {
                    HStack(spacing: 12) {
                        Label("Long press and drag", systemImage: "hand.draw")
                        Label("Move cards across both groups", systemImage: "square.split.2x1")
                    }
                }
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(primaryTextColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)

            if isPreview {
                Text("Preview mode disables the drag gesture to avoid canvas crashes.")
                    .font(.footnote)
                    .foregroundStyle(secondaryTextColor)
            }

            Button("Reset Cards") {
                withAnimation(.snappy) {
                    lanes = Self.initialLanes
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(resetButtonTint)
            .foregroundStyle(colorScheme == .dark ? .black : .white)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(headerSurfaceColor, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(colorScheme == .dark ? .white.opacity(0.12) : .white.opacity(0.3))
        }
    }

    @ViewBuilder
    private var laneGrid: some View {
        if isCompactWidth {
            // Stack the collections vertically on iPhone portrait so each card has
            // enough width to show both its title and detail text.
            VStack(spacing: 18) {
                ForEach(lanes) { lane in
                    laneColumn(lane)
                }
            }
            .reorderContainer(
                for: ReorderCard.self,
                in: ReorderLaneID.self,
                isEnabled: !isPreview
            ) { difference in
                move(difference)
            }
        } else {
            // On wider layouts, keep both collections visible side-by-side so cross-
            // collection dragging still feels spatially direct.
            HStack(alignment: .top, spacing: 18) {
                ForEach(lanes) { lane in
                    laneColumn(lane)
                        .frame(maxWidth: .infinity, alignment: .top)
                }
            }
            .reorderContainer(
                for: ReorderCard.self,
                in: ReorderLaneID.self,
                isEnabled: !isPreview
            ) { difference in
                move(difference)
            }
        }
    }

    @ViewBuilder
    private func laneColumn(_ lane: ReorderLane) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(lane.id.rawValue)
                    .font(.title3.bold())
                    .foregroundStyle(primaryTextColor)
                Text(lane.description)
                    .font(.footnote)
                    .foregroundStyle(secondaryTextColor)
            }

            VStack(spacing: 12) {
                ForEach(lane.cards) { card in
                    cardView(card)
                }
                .reorderable(collectionID: lane.id)
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(laneSurfaceColor, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(colorScheme == .dark ? .white.opacity(0.14) : .white.opacity(0.35))
        }
    }

    private func cardView(_ card: ReorderCard) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [card.accent.primary, card.accent.primary.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: card.systemImage)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(primaryTextColor)
                Text(card.detail)
                    .font(.footnote)
                    .foregroundStyle(secondaryTextColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "line.3.horizontal")
                .font(.footnote.weight(.bold))
                .foregroundStyle(secondaryTextColor)
                .padding(.leading, 4)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardSurfaceColor, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 12, y: 6)
    }

    private var backgroundGradient: some View {
        Group {
            if colorScheme == .dark {
                LinearGradient(
                    colors: [
                        Color(red: 0.10, green: 0.11, blue: 0.15),
                        Color(red: 0.14, green: 0.16, blue: 0.22),
                        Color(red: 0.12, green: 0.10, blue: 0.16),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            } else {
                LinearGradient(
                    colors: [
                        Color(red: 0.99, green: 0.95, blue: 0.88),
                        Color(red: 0.90, green: 0.94, blue: 0.98),
                        Color(red: 0.96, green: 0.90, blue: 0.93),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
        .ignoresSafeArea()
    }

    private func move(_ difference: ReorderDifference<ReorderCard.ID, ReorderLaneID>) {
        // ReorderDifference gives moved item IDs plus the destination collection
        // and position. Resolve the IDs back to stable models first so the move
        // still works correctly even after removing them from their source lane.
        let movedIDs = Set(difference.sources)
        let cardsByID = Dictionary(
            uniqueKeysWithValues: lanes
                .flatMap(\.cards)
                .map { ($0.id, $0) }
        )

        let movedCards = difference.sources.compactMap { cardsByID[$0] }

        for index in lanes.indices {
            lanes[index].cards.removeAll { movedIDs.contains($0.id) }
        }

        guard let destinationLaneIndex = lanes.firstIndex(where: {
            $0.id == difference.destination.collectionID
        }) else {
            return
        }

        // The destination is expressed relative to the post-removal collection:
        // insert before a concrete card when provided, otherwise append to the end.
        let insertIndex: Int = switch difference.destination.position {
        case let .before(targetID):
            lanes[destinationLaneIndex].cards.firstIndex(where: {
                $0.id == targetID
            }) ?? lanes[destinationLaneIndex].cards.endIndex
        case .end:
            lanes[destinationLaneIndex].cards.endIndex
        }

        lanes[destinationLaneIndex].cards.insert(
            contentsOf: movedCards,
            at: insertIndex
        )
    }
}

@available(iOS 27.0, *)
private extension ReorderContainerDemo {
    static var initialLanes: [ReorderLane] {
        [
            ReorderLane(
                id: .now,
                description: "Pin your active cards here.",
                cards: [
                    ReorderCard(
                        title: "Evening Run",
                        detail: "High tempo mix",
                        systemImage: "figure.run",
                        accent: .coral
                    ),
                    ReorderCard(
                        title: "Focus Block",
                        detail: "Deep work playlist",
                        systemImage: "brain.head.profile",
                        accent: .sky
                    ),
                    ReorderCard(
                        title: "Reading Queue",
                        detail: "Long-form articles",
                        systemImage: "book.pages",
                        accent: .lime
                    ),
                ]
            ),
            ReorderLane(
                id: .next,
                description: "Drop cards here for later.",
                cards: [
                    ReorderCard(
                        title: "Design Review",
                        detail: "Feedback checklist",
                        systemImage: "paintpalette",
                        accent: .gold
                    ),
                    ReorderCard(
                        title: "Weekend Trip",
                        detail: "Packing shortlist",
                        systemImage: "suitcase.rolling",
                        accent: .pink
                    ),
                    ReorderCard(
                        title: "Inbox Sweep",
                        detail: "Quick admin tasks",
                        systemImage: "tray.full",
                        accent: .teal
                    ),
                ]
            ),
        ]
    }
}

#Preview {
    NavigationStack {
        ReorderContainerPractice()
    }
}
