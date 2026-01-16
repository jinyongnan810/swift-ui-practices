# Scroll Transition Example

Scroll-based visual effects with phase-driven transitions and scroll position tracking.

## Techniques & Tips

### scrollTransition Modifier
- `.scrollTransition(axis:) { content, phase in }` applies effects during scroll
- `phase.value` ranges from -1 to 1 (before/after visible)
- `phase.isIdentity` is true when fully visible

### Phase-Based Effects
- Calculate opacity from phase: `1 - abs(phase.value)`
- Apply offset: `phase.value * -300` for parallax
- Grayscale based on distance: `.grayscale(abs(phase.value))`

### Container Relative Frame
- `.containerRelativeFrame(.horizontal)` sizes to scroll container
- Each item fills horizontal space of ScrollView

### Scroll Offset Tracking
- Custom `PreferenceKey` for scroll position
- `GeometryReader` inside scroll content
- `.frame(in: .named("scrollView"))` gets position in coordinate space

### PreferenceKey Pattern
```swift
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
```

### Coordinate Space
- `.coordinateSpace(name: "scrollView")` defines reference frame
- `geometry.frame(in: .named(...)).minX` tracks scroll position

### Multiple Effect Combinations
- Opacity fade as items scroll away
- Horizontal offset for parallax effect
- Grayscale for visual depth
- Can add scale, rotation, brightness, etc.

## Key APIs
- `.scrollTransition(axis:)`
- `ScrollTransitionPhase`
- `phase.value` / `phase.isIdentity`
- `.containerRelativeFrame()`
- `PreferenceKey`
- `.preference(key:value:)`
- `.onPreferenceChange()`
- `.coordinateSpace(name:)`
- `GeometryReader`
