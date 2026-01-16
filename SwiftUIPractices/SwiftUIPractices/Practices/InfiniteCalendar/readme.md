## Core Concepts

1. **Infinite Scrolling Pattern**
   - Dynamic content loading at scroll boundaries (top/bottom thresholds)
   - Memory-bounded window: maintains only 30 months in memory
   - Seamless user experience: loads appear instantaneous

2. **Scroll Position Management**
   - Uses `scrollPosition(_:)` for programmatic scroll control
   - Uses `onScrollGeometryChange(for:of:action:)` to monitor scroll metrics
   - Critical metrics tracked: offsetY, contentHeight, containerHeight

3. **Content Offset Adjustment**
   - When inserting content at index 0, adjusts scroll position to maintain view
   - Prevents jarring jumps when months are added/removed
   - Uses `scrollPositionUpdatePreservesVelocity` to maintain scroll momentum

## Key SwiftUI APIs

- `LazyVStack`: Lazy loading of month views for performance
- `scrollPosition(_:)`: Binding for programmatic scroll control
- `onScrollGeometryChange(for:of:action:)`: Monitor scroll position and content size
- `defaultScrollAnchor(.center)`: Initial scroll anchor point
- `safeAreaInset(edge:content:)`: Sticky header for weekday symbols
- `UIViewRepresentable`: Bridge to UIKit for disabling scrollsToTop
- `Transaction(scrollPositionUpdatePreservesVelocity:)`: Smooth scroll adjustments

## Performance Optimizations

1. **LazyVStack**: Only renders visible months
2. **Bounded Memory**: Removes old months when count exceeds 30
3. **Debouncing**: Uses loading flags to prevent simultaneous loads
4. **Threshold-based Loading**: Only loads when within 100px of edges

## Edge Cases Handled

1. **Floating-point Precision**: Ignores offsetY values < 1.0px
2. **Initial Layout Race Condition**: Delays initial scroll by 0.1s
3. **Triple-load Prevention**: Guards prevent re-entry + 0.3-0.5s cooldown
4. **Scroll Momentum Preservation**: Uses transaction to avoid stopping scroll
5. **Content Insertion Impact**: Always adjusts offset when adding months

## Calendar-specific Techniques

1. **Week Grid Layout**: Each month divided into weeks, each week has 7 days
2. **Placeholder Days**: Empty cells for days outside current month
3. **Today Highlighting**: Circular blue background for current date
4. **Localized Symbols**: Uses `Calendar.current.shortWeekdaySymbols`

## Testing Considerations

- Initial month generation creates 10 months (5 past + current + 4 future)
- Each month height is constant: 400px
- Load threshold: 100px from top/bottom triggers loading
- Memory limit: 30 months maximum (12,000px total content)

## Common Pitfalls Avoided

1. ❌ Not adjusting scroll after inserting at index 0 → ✅ Always call adjustContentOffset
2. ❌ Checking count > 30 before adjusting → ✅ Always adjust, conditionally remove
3. ❌ Using .async for loading flag reset → ✅ Use .asyncAfter with delay
4. ❌ Adjusting scroll without transaction → ✅ Use scrollPositionUpdatePreservesVelocity
5. ❌ Immediate scroll on onAppear → ✅ Delay by 0.1s for layout stability