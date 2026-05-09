//
//  SwipeSidebarPractice.swift
//  SwiftUIPractices
//
//  Created by Codex on 2026/05/09.
//  Learned from Kavsoft: https://youtu.be/aJ3969UVDaI
//

import SwiftUI
import UIKit

struct SwipeSidebarWrapper<Sidebar: View, MainContent: View>: View {
    // Key point: the sidebar has a fixed width, and every offset/progress value
    // is derived from this single number.
    private let sidebarWidth: CGFloat = 280
    // The main content has rounded leading corners. Drawing the sidebar slightly
    // past 280 fills the area revealed behind those clipped corners.
    private let sidebarUnderlap: CGFloat = 80
    private let animation = Animation.spring(response: 0.32, dampingFraction: 0.86)

    // These bindings let the wrapper respond to external state changes and also
    // publish internal gesture decisions back to the parent.
    @Binding private var isExpanded: Bool
    @Binding private var isEnabled: Bool

    // The sidebar receives progress so its own content can react to the drag,
    // while main content is built once and moved as a single surface.
    @ViewBuilder private let sidebar: (CGFloat) -> Sidebar
    @ViewBuilder private let mainContent: MainContent

    // xOffset drives the main content position. progress is normalized to 0...1
    // and is used for secondary effects like opacity, font size, and overlays.
    @State private var xOffset: CGFloat = 0
    @State private var dragStartOffset: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var isPanning = false

    init(
        isExpanded: Binding<Bool>,
        isEnabled: Binding<Bool>,
        @ViewBuilder sidebar: @escaping (CGFloat) -> Sidebar,
        @ViewBuilder mainContent: () -> MainContent
    ) {
        _isExpanded = isExpanded
        _isEnabled = isEnabled
        self.sidebar = sidebar
        self.mainContent = mainContent()
    }

    var body: some View {
        // The sidebar and main content are stacked; the sidebar is revealed only
        // because the main content slides horizontally.
        ZStack(alignment: .leading) {
            sidebar(progress)
                .compositingGroup()
                .frame(width: sidebarWidth + sidebarUnderlap, alignment: .leading)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()

            mainContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .background {
                    ConcentricRectangle(corners: .concentric, isUniform: true)
                        .fill(.background)
                }

                .overlay {
                    // The main content becomes visually inactive as the sidebar opens.
                    Color.gray
                        .opacity(0.38 * progress)
                        .allowsHitTesting(false)
                }
                // Keep the main content and gray overlay inside one shaped surface.
                .clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
                .overlay {
                    if isExpanded {
                        // When expanded, the shifted main content becomes a tap target
                        // for collapsing the sidebar.
                        Color.clear
                            .contentShape(ConcentricRectangle(corners: .concentric, isUniform: true))
                            .onTapGesture {
                                setExpanded(false, animated: true)
                            }
                    }
                }
                .offset(x: xOffset)
                .shadow(radius: 10)
                .compositingGroup()
                // During an active pan, UIKit is already providing continuous updates.
                // Springs are restored for snap-open and snap-closed transitions.
                .animation(isPanning ? nil : animation, value: xOffset)
                .gesture(sidebarPanGesture)
        }
        .ignoresSafeArea()
        .onAppear {
            updateOffset(for: isExpanded, animated: false)
        }
        .onChange(of: isExpanded) { _, newValue in
            // External changes to isExpanded stay in sync with the internal offset.
            updateOffset(for: newValue, animated: true)
        }
        .onChange(of: isEnabled) { _, newValue in
            guard !newValue else { return }
            // If navigation or another mode disables the sidebar, collapse it first.
            setExpanded(false, animated: true)
        }
    }

    private var sidebarPanGesture: SidebarPanGesture {
        SidebarPanGesture(
            isEnabled: isEnabled,
            isExpanded: isExpanded,
            sidebarWidth: sidebarWidth,
            onBegan: {
                isPanning = true
                dragStartOffset = xOffset
            },
            onChanged: { translationX in
                let nextOffset = (dragStartOffset + translationX).clamped(to: 0 ... sidebarWidth)
                setOffset(nextOffset)
            },
            onEnded: { translationX, velocityX in
                isPanning = false

                // Snap decision: final translation plus a velocity projection must
                // pass half the sidebar width to open fully.
                let predictedOffset = dragStartOffset + translationX + velocityX
                setExpanded(predictedOffset > sidebarWidth / 2, animated: true)
            },
            onCancelled: {
                isPanning = false
                setExpanded(isExpanded, animated: true)
            }
        )
    }

    private func setExpanded(_ expanded: Bool, animated: Bool) {
        let changes = {
            isExpanded = expanded
            setOffset(expanded ? sidebarWidth : 0)
        }

        if animated {
            withAnimation(animation, changes)
        } else {
            changes()
        }
    }

    private func updateOffset(for expanded: Bool, animated: Bool) {
        let targetOffset = expanded ? sidebarWidth : 0

        if animated {
            withAnimation(animation) {
                setOffset(targetOffset)
            }
        } else {
            setOffset(targetOffset)
        }
    }

    private func setOffset(_ offset: CGFloat) {
        xOffset = offset
        progress = (offset / sidebarWidth).clamped(to: 0 ... 1)
    }
}

// UIGestureRecognizerRepresentable is used here instead of SwiftUI DragGesture so
// the sidebar can participate in UIKit gesture arbitration with nested scroll views.
struct SidebarPanGesture: UIGestureRecognizerRepresentable {
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var isEnabled = true
        var isExpanded = false
        var sidebarWidth: CGFloat = 280

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            guard isEnabled, let pan = gestureRecognizer as? UIPanGestureRecognizer else {
                return false
            }

            let velocity = pan.velocity(in: pan.view)
            // Ignore vertical or diagonal gestures so normal scrolling still wins.
            guard abs(velocity.x) > abs(velocity.y), velocity.x != 0 else {
                return false
            }

            if isExpanded {
                return true
            }

            guard velocity.x > 0 else {
                return false
            }

            // If a nested horizontal scroll view is already scrolled to the right,
            // that scroll view owns the gesture. The sidebar starts only at x <= 0.
            return canStartAlongsideHorizontalScroll(from: pan)
        }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            guard isEnabled,
                  let pan = gestureRecognizer as? UIPanGestureRecognizer,
                  isHorizontalPan(pan)
            else {
                return false
            }

            guard let scrollOffset = otherHorizontalScrollOffset(from: otherGestureRecognizer) else {
                return false
            }

            // Simultaneous recognition is allowed only when the other horizontal
            // scroll is at, or before, its leading edge.
            return scrollOffset <= 0
        }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            guard isEnabled,
                  let pan = gestureRecognizer as? UIPanGestureRecognizer,
                  isHorizontalPan(pan),
                  let scrollOffset = otherHorizontalScrollOffset(from: otherGestureRecognizer)
            else {
                return false
            }

            // When the nested horizontal scroll can still move back, require it
            // to fail before the sidebar can take over.
            return scrollOffset > 0
        }

        private func canStartAlongsideHorizontalScroll(from pan: UIPanGestureRecognizer) -> Bool {
            guard let view = pan.view else { return true }

            let horizontalScrollViews = view.gestureRecognizers?
                .compactMap(otherHorizontalScrollOffset)
                ?? []

            guard !horizontalScrollViews.isEmpty else { return true }

            return horizontalScrollViews.allSatisfy { $0 <= 0 }
        }

        private func isHorizontalPan(_ pan: UIPanGestureRecognizer) -> Bool {
            let velocity = pan.velocity(in: pan.view)
            return abs(velocity.x) > abs(velocity.y)
        }

        private func otherHorizontalScrollOffset(from recognizer: UIGestureRecognizer) -> CGFloat? {
            guard let scrollView = recognizer.view as? UIScrollView ?? recognizer.view?.nearestSuperview(of: UIScrollView.self) else {
                return nil
            }

            let canScrollHorizontally = scrollView.contentSize.width > scrollView.bounds.width
            guard canScrollHorizontally else { return nil }

            return scrollView.contentOffset.x + scrollView.adjustedContentInset.left
        }
    }

    var isEnabled: Bool
    var isExpanded: Bool
    var sidebarWidth: CGFloat
    var onBegan: () -> Void
    var onChanged: (CGFloat) -> Void
    var onEnded: (CGFloat, CGFloat) -> Void
    var onCancelled: () -> Void

    func makeCoordinator(converter _: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }

    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let recognizer = UIPanGestureRecognizer()
        recognizer.delegate = context.coordinator
        recognizer.maximumNumberOfTouches = 1

        context.coordinator.isEnabled = isEnabled
        context.coordinator.isExpanded = isExpanded
        context.coordinator.sidebarWidth = sidebarWidth

        return recognizer
    }

    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
        recognizer.isEnabled = isEnabled
        context.coordinator.isEnabled = isEnabled
        context.coordinator.isExpanded = isExpanded
        context.coordinator.sidebarWidth = sidebarWidth
    }

    func handleUIGestureRecognizerAction(
        _ recognizer: UIPanGestureRecognizer,
        context _: Context
    ) {
        switch recognizer.state {
        case .began:
            onBegan()
        case .changed:
            onChanged(recognizer.translation(in: recognizer.view).x)
        case .ended:
            let translationX = recognizer.translation(in: recognizer.view).x
            // Velocity is scaled into a distance-like projection so a quick swipe
            // can open or close even when the raw translation is short.
            let velocityX = recognizer.velocity(in: recognizer.view).x * 0.18
            onEnded(translationX, velocityX)
        case .cancelled, .failed:
            onCancelled()
        default:
            break
        }
    }
}

struct SwipeSidebarPractice: View {
    private let navigationOverlayInset: CGFloat = 86

    private enum SidebarItem: String, CaseIterable, Hashable {
        case dashboard = "Dashboard"
        case messages = "Messages"
        case calendar = "Calendar"
        case settings = "Settings"

        var iconName: String {
            switch self {
            case .dashboard:
                "square.grid.2x2"
            case .messages:
                "bubble.left.and.bubble.right"
            case .calendar:
                "calendar"
            case .settings:
                "gearshape"
            }
        }
    }

    // Demo state: navigation disables the sidebar swipe, while the toggles show
    // that the wrapper can also be controlled from outside.
    @State private var isExpanded = false
    @State private var isSidebarEnabled = true
    @State private var rootPathCount = 0
    @Binding private var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
    }

    var body: some View {
        SwipeSidebarWrapper(
            isExpanded: $isExpanded,
            isEnabled: $isSidebarEnabled
        ) { progress in
            practiceSidebar(progress: progress)
        } mainContent: {
            List {
                Color.clear
                    .frame(height: navigationOverlayInset)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                Section("Main Content") {
                    ForEach(1 ... 16, id: \.self) { index in
                        NavigationLink(value: index) {
                            Label("Practice Row \(index)", systemImage: "doc.text")
                        }
                    }
                }

                Section("External State") {
                    Toggle("Expanded", isOn: $isExpanded.animation())
                    Toggle("Swipe Enabled", isOn: $isSidebarEnabled.animation())
                }
            }

            .navigationTitle("Swipe Sidebar")
            .navigationDestination(for: Int.self) { index in
                Text("Detail \(index)")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.background)
            }
            .navigationDestination(for: SidebarItem.self) { item in
                Color.clear
                    .background(.background)
                    .navigationTitle(item.rawValue)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            rootPathCount = path.count
            isSidebarEnabled = true
        }
        .onChange(of: path) { _, newValue in
            isSidebarEnabled = newValue.count <= rootPathCount
        }
    }

    private func practiceSidebar(progress: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Sidebar")
                // This is the visual reference for progress-driven sidebar content.
                .font(.system(size: 30 + (progress * 6), weight: .bold))
                .opacity(0.35 + (progress * 0.65))
                .padding(.bottom, 10)

            ForEach(SidebarItem.allCases, id: \.self) { item in
                Button {
                    openSidebarItem(item)
                } label: {
                    Label(item.rawValue, systemImage: item.iconName)
                        .font(.system(size: 16 + (progress * 2), weight: .semibold))
                        .opacity(0.2 + (progress * 0.8))
                }
                .buttonStyle(.plain)
            }

            Spacer()
        }
        .padding(.top, 72)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.blue.gradient)
        .foregroundStyle(.white)
    }

    private func openSidebarItem(_ item: SidebarItem) {
        withAnimation(.spring(response: 0.32, dampingFraction: 0.86)) {
            isExpanded = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            path.append(item)
        }
    }
}

private extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

private extension UIView {
    func nearestSuperview<T: UIView>(of _: T.Type) -> T? {
        var nextSuperview = superview

        while let current = nextSuperview {
            if let typedSuperview = current as? T {
                return typedSuperview
            }

            nextSuperview = current.superview
        }

        return nil
    }
}

#Preview {
    SwipeSidebarPracticePreview()
}

private struct SwipeSidebarPracticePreview: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            SwipeSidebarPractice(path: $path)
        }
    }
}
