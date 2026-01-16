# Dynamic Island Example

Toast notification that expands from the Dynamic Island with fallback for non-supported devices.

## Techniques & Tips

### Dynamic Island Detection
- Check `safeArea.top >= 59` to detect Dynamic Island presence
- Fallback animation for older devices (slide from top)

### PassthroughWindow
- Custom `UIWindow` subclass for overlay content
- Override `hitTest(_:with:)` to allow touch passthrough
- Only intercepts touches on toast area

### @Observable for Window State
- `@Observable class PassthroughWindow` for reactive state
- Properties: `text`, `isPresented`
- SwiftUI automatically observes changes

### UIViewRepresentable for Window Access
- `WindowExtractor` gets current `UIWindow` from SwiftUI hierarchy
- `DispatchQueue.main.async` ensures view is in window hierarchy

### Custom UIHostingController
- `CustomHostingView` controls status bar visibility
- `prefersStatusBarHidden` hides status bar during toast
- `setNeedsStatusBarAppearanceUpdate()` triggers refresh

### Expansion Animation
- Scale transform from Dynamic Island size to expanded size
- `scaleX` and `scaleY` calculated from size ratios
- `.animation(.bouncy(duration:extraBounce:))` for bounce effect

### ConcentricRectangle Shape
- Custom shape with concentric corner radii
- Maintains consistent corner appearance at any size

### Gesture Dismissal
- `DragGesture` detects upward swipe
- `value.translation.height < 0` triggers dismiss

### Content Blur Transition
- `.blur(radius:)` and `.opacity()` for content fade
- `.compositingGroup()` ensures proper blur rendering
- `.geometryGroup()` for animation consistency

## Key APIs
- `@Observable`
- `UIWindow` subclass
- `hitTest(_:with:)`
- `UIViewRepresentable`
- `UIHostingController`
- `.presentationDetents()`
- `DragGesture`
- `.animation(.bouncy())`
- `.geometryGroup()`
- `.compositingGroup()`
