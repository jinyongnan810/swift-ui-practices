# Custom Tooltip Practice

A reusable tooltip component that displays contextual messages on long press.

## Techniques & Tips

### Generic View Builder Pattern
- `CustomToolTipView<Content: View, Message: View>` accepts any view types
- `@ViewBuilder` closures for flexible content and message composition
- Enables reuse with different content types (images, text, etc.)

### Long Press Gesture
- `LongPressGesture(minimumDuration: 0.4)` for tooltip trigger
- `.onEnded {}` to show tooltip after gesture completes
- Auto-dismiss after 2 seconds using `DispatchQueue.main.asyncAfter()`

### Gesture State (Alternative Approach)
- Commented code shows `@GestureState` and `.updating()` pattern
- Useful when tooltip should show only while pressing

### Overlay with Opacity Animation
- Message view overlaid on content using `ZStack`
- `.opacity()` controlled by `isShowingToolTip` state
- `.animation(.spring, value:)` for smooth show/hide transitions

### Tooltip Message Styling
- Gradient-filled rounded rectangle background
- `.shadow()` for floating effect
- Customizable text content

## Key APIs
- `@ViewBuilder`
- Generic view types (`<Content: View, Message: View>`)
- `LongPressGesture`
- `@GestureState` (alternative)
- `.gesture()`
- `.opacity()`
- `.animation(.spring, value:)`
- `DispatchQueue.main.asyncAfter()`
