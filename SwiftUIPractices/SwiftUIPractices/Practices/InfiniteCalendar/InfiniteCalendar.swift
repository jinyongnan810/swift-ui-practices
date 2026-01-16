//
//  InfiniteCalendar.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/12.
//
// Learning from Kavsoft: https://www.youtube.com/watch?v=5Bmi8tlb4bg
//
// MARK: - Techniques & Tips Used
//

import SwiftUI

// MARK: - Constants

/// Height of each month view in the calendar
let monthHeight: CGFloat = 400

/// Distance threshold from top/bottom edge that triggers loading more months
let loadThreshold: CGFloat = 100

// MARK: - Main Calendar View

/// An infinite scrolling calendar that dynamically loads months as the user scrolls
/// The calendar maintains a window of months and loads more content as needed to create
/// an infinite scrolling experience
struct InfiniteCalendar: View {
    /// Array of months currently visible in the scroll view
    @State private var months: [Month] = []

    /// Tracks the current scroll position to enable programmatic scrolling
    @State private var scrollPosition: ScrollPosition = .init()

    /// Flags to prevent simultaneous loading of past/future months
    @State private var isLoadingTop: Bool = false
    @State private var isLoadingBottom: Bool = false

    /// Flag to prevent loading during reset to initial state
    @State private var isResetting: Bool = false

    var body: some View {
        ScrollView(.vertical) {
            // LazyVStack loads month views on demand for better performance
            LazyVStack(spacing: 0) {
                ForEach(months) { month in
                    MonthView(month: month)
                        .frame(height: monthHeight)
                }
            }
        }
        // Bind scroll position for programmatic control
        .scrollPosition($scrollPosition)
        // Start with content centered when first appearing
        .defaultScrollAnchor(.center)
        // Monitor scroll geometry to detect when to load more months
        .onScrollGeometryChange(
            for: ScrollInfo.self,
            of: { geo in
                // Calculate key scroll metrics:
                // - offsetY: How far down the user has scrolled from the top of the content
                //   (adjusted for safe area insets like status bar)
                // - contentHeight: Total height of all scrollable content (sum of all month views)
                // - containerHeight: Height of the visible viewport (screen area showing the content)
                let offsetY = geo.contentOffset.y + geo.contentInsets.top
                let contentHeight = geo.contentSize.height
                let containerHeight = geo.containerSize.height
                return .init(
                    offsetY: offsetY,
                    contentHeight: contentHeight,
                    containerHeight: containerHeight
                )
            },
            action: {
                _,
                    newValue in
                // Only trigger loading if we have initial months, not resetting, and not already loading
                guard months.count >= 10, !isResetting, !isLoadingTop, !isLoadingBottom else {
                    return
                }

                let offsetY = newValue.offsetY
                let contentHeight = newValue.contentHeight
                let containerHeight = newValue.containerHeight

                // Ignore very small offset values (floating-point precision errors near zero)
                // This prevents premature loading during initial layout and scroll positioning
                guard abs(offsetY) > 1.0 else {
                    return
                }

                // Load future months when scrolling near the bottom
                if offsetY > (contentHeight - containerHeight - loadThreshold) {
                    print("🚀 load future")
                    loadingFutureMonths(scrollInfo: newValue)
                }

                // Load past months when scrolling near the top
                if offsetY < loadThreshold {
                    print("🚀 load past")
                    loadingPastMonths(scrollInfo: newValue)
                }
            }
        )
        // Disable the default tap-status-bar-to-scroll-to-top behavior
        .background {
            ScrollToTopDisable()
        }
        // Composite the scroll content as a single layer for better performance
        .compositingGroup()
        // Add week day labels at the top
        .safeAreaInset(edge: .top, content: {
            WeekSymbolView()
        })
        // Add bottom bar with navigation controls
        .overlay(alignment: .bottom) {
            BottomBar()
        }
        // Initialize calendar on first appearance
        .onAppear {
            guard months.isEmpty else { return }
            loadInitialMonths()
        }
    }

    // MARK: - Dynamic Loading Methods

    /// Loads future months when user scrolls toward the bottom
    /// - Parameter scrollInfo: Current scroll position information
    private func loadingFutureMonths(scrollInfo: ScrollInfo) {
        // Prevent multiple simultaneous loads
        guard !isLoadingBottom else { return }
        isLoadingBottom = true

        // Generate 10 months into the future
        let futureMonths = months.createMonths(count: 10, isPast: false)
        months.append(contentsOf: futureMonths)

        adjustContentOffset(removesTop: true, info: scrollInfo)

        // Delay before allowing next load to prevent rapid successive loads
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isLoadingBottom = false
        }
    }

    /// Loads past months when user scrolls toward the top
    /// - Parameter scrollInfo: Current scroll position information
    private func loadingPastMonths(scrollInfo: ScrollInfo) {
        // Prevent multiple simultaneous loads
        guard !isLoadingTop else { return }
        isLoadingTop = true

        // Generate 10 months into the past
        let pastMonths = months.createMonths(count: 10, isPast: true)

        // Insert at the beginning to maintain chronological order
        months.insert(contentsOf: pastMonths, at: 0)

        adjustContentOffset(removesTop: false, info: scrollInfo)

        // Delay before allowing next load to prevent rapid successive loads
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("✅ Reset isLoadingTop")
            isLoadingTop = false
        }
    }

    /// Loads the initial set of months centered on the current date
    /// Generates 10 months total (5 past, current, 4 future) and scrolls to center
    private func loadInitialMonths() {
        months = Date.now.initialMonths

        // Delay the scroll to ensure the layout is complete before scrolling
        // This prevents triggering the load threshold check during initial positioning
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Calculate the Y offset to center the current month in the viewport
            // months.count / 2 gives us the middle month (current month)
            let centerOffset = CGFloat(months.count / 2) * monthHeight - monthHeight / 2
            scrollPosition.scrollTo(y: centerOffset)
        }
    }

    /// Adjusts scroll position when adding/removing months to maintain user's view
    /// This prevents jarring jumps when months are dynamically loaded or removed
    ///
    /// # How This Works:
    ///
    /// When months are inserted at the beginning (index 0), the content shifts down.
    /// Without adjustment, the user would see a sudden jump as their view moves with the content.
    ///
    /// Example scenario when loading past months:
    /// 1. User is at offsetY = 98px (near top threshold)
    /// 2. Insert 10 months at beginning (adds 4000px of content above current position)
    /// 3. Without adjustment: User still at offsetY = 98px, but now viewing wrong content
    /// 4. With adjustment: offsetY updated to 4098px, maintaining the same visual position
    ///
    /// Visual representation:
    /// ```
    /// Before insertion:          After insertion (no adjustment):    After adjustment:
    /// ┌──────────────┐          ┌──────────────┐                   ┌──────────────┐
    /// │ Month 1      │          │ NEW Month -9 │                   │ NEW Month -9 │
    /// │ Month 2      │          │ NEW Month -8 │                   │ ...          │
    /// │ Month 3      │          │ ...          │                   │ NEW Month 0  │
    /// ├──────────────┤ ← 98px   │ NEW Month 0  │                   ├──────────────┤ ← 4098px
    /// │ [User View]  │          │ Month 1      │ ← User still at   │ [User View]  │ ← Same view!
    /// │              │          ├──────────────┤   98px (wrong!)   │              │
    /// └──────────────┘          │ [Wrong View] │                   └──────────────┘
    /// ```
    ///
    /// - Parameters:
    ///   - removesTop: If true, removes old months from top; if false, removes from bottom
    ///                 This only affects memory management when count > 30
    ///   - info: Current scroll metrics before any changes (offsetY, contentHeight, containerHeight)
    private func adjustContentOffset(removesTop: Bool, info: ScrollInfo) {
        let previousContentHeight = info.contentHeight
        let previousOffset = info.offsetY

        // Height of 10 months that were just added (and may be removed if count > 30)
        // Each month is 400px tall, so 10 months = 4000px
        let adjustHeight: CGFloat = monthHeight * 10

        // MEMORY MANAGEMENT: Remove old months from the opposite end when exceeding 30 total
        // This keeps memory bounded while maintaining infinite scrolling illusion
        if removesTop {
            // When loading future months (scrolling down), remove oldest past months
            if months.count > 30 {
                months.removeFirst(10)
            }
        } else {
            // When loading past months (scrolling up), remove oldest future months
            if months.count > 30 {
                months.removeLast(10)
            }
        }

        // Calculate the new total content height after our changes
        // - When loading PAST months: we ADD content at top, increasing height
        //   (even if we remove from bottom, net change is still +adjustHeight)
        // - When loading FUTURE months: we ADD content at bottom, but if we remove from top,
        //   the net effect depends on what was removed
        let newContentHeight = previousContentHeight + (
            removesTop ? -adjustHeight // Removed from top: height decreases
                : adjustHeight // Added at top: height increases
        )

        // Calculate how much to adjust the scroll offset to maintain user's visual position
        // This is the difference between new and old content heights
        // - Positive value: scroll position moves down (content added above)
        // - Negative value: scroll position moves up (content removed above)
        let newOffset = previousOffset + (
            newContentHeight - previousContentHeight)

        // CRITICAL: Use a transaction with scrollPositionUpdatePreservesVelocity
        // Without this, adjusting scroll position during an active scroll gesture
        // would stop the scrolling momentum abruptly, creating a jarring experience
        // With this flag, the adjustment happens smoothly while preserving user's scroll velocity
        var transaction = Transaction()
        transaction.scrollPositionUpdatePreservesVelocity = true
        withTransaction(transaction) {
            scrollPosition.scrollTo(y: newOffset)
        }
    }

    // MARK: - UI Components

    /// Bottom bar with navigation controls and debug information
    @ViewBuilder
    func BottomBar() -> some View {
        HStack {
            // Button to jump back to current month
            Button {
                isResetting = true
                loadInitialMonths()
                DispatchQueue.main.async {
                    isResetting = false
                }
            } label: {
                Text("Today")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
                    .background(.background, in: .capsule)
            }
            Spacer()
            // Display current month count for debugging
            Text("Count: \(months.count)").padding()
                .background(.background, in: .capsule)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
    }
}

// MARK: - Month View

/// Displays a single month with its name and weeks
struct MonthView: View {
    let month: Month

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Month name header (e.g., "2026 January")
            Text(month.name)
                .font(.title)
                .fontWeight(.bold)
                .frame(height: 50, alignment: .bottom)

            // Grid of weeks for this month
            VStack(alignment: .leading, spacing: 0) {
                ForEach(month.weeks) { week in
                    WeekView(week: week)
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

// MARK: - Week Symbol View

/// Header view showing weekday abbreviations (Sun, Mon, Tue, etc.)
struct WeekSymbolView: View {
    var body: some View {
        HStack(spacing: 0) {
            // Display localized weekday symbols (e.g., "Sun", "Mon", "Tue")
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .overlay(alignment: .bottom) {
            Divider()
        }
        .background(.ultraThinMaterial)
    }
}

// MARK: - Week View

/// Displays a single week row with 7 day cells
struct WeekView: View {
    let week: Week

    var body: some View {
        HStack(spacing: 0) {
            // Each week always has 7 days (some may be placeholders)
            ForEach(week.days) { day in
                DayView(day: day)
            }
        }
        .frame(maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            // Add divider between weeks, except for the last week of the month
            if !week.isLast {
                Divider()
            }
        }
    }
}

// MARK: - Day View

/// Displays a single day cell in the calendar grid
struct DayView: View {
    let day: Day

    var body: some View {
        // Only render real days (not placeholder days from adjacent months)
        if let dayValue = day.value, let date = day.date, !day.isPlaceholder {
            let isToday = Calendar.current.isDateInToday(date)

            Text("\(dayValue)")
                .font(.callout)
                .fontWeight(isToday ? .semibold : .regular)
                .foregroundStyle(isToday ? .white : .primary)
                .frame(width: 50, height: 50)
                .background {
                    // Highlight today's date with a blue circle
                    if isToday {
                        Circle()
                            .fill(Color.blue.gradient)
                    }
                }
                .frame(maxWidth: .infinity)
        } else {
            // Placeholder for days outside the current month
            Color.clear
        }
    }
}

// MARK: - Helper Views

/// Helper view that disables the default "tap status bar to scroll to top" behavior
/// This prevents accidental jumps to the top when the user taps the status bar
/// which would disrupt the infinite scrolling experience
struct ScrollToTopDisable: UIViewRepresentable {
    func makeUIView(context _: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear

        // Navigate up the view hierarchy to find the UIScrollView and disable scrollsToTop
        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.subviews.last?.subviews.first as? UIScrollView {
                scrollView.scrollsToTop = false
            }
        }

        return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}
}

// MARK: - Preview

#Preview {
    InfiniteCalendar()
}
