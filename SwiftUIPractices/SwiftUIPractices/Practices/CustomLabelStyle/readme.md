# Custom Label Style Practice

Demonstrates creating a custom `LabelStyle` with tap animations and gradient backgrounds.

## Techniques & Tips

### Custom LabelStyle Protocol
- Implement `LabelStyle` protocol with `makeBody(configuration:)` method
- Access `configuration.title` and `configuration.icon` to arrange label components
- Reverse default order (title before icon) for custom layout

### Tap Gesture with Feedback Animation
- `onTapGesture {}` for handling user interaction
- Opacity animation on tap (1.0 -> 0.3 -> 1.0)
- `DispatchQueue.main.asyncAfter()` for delayed animation reset

### State Management in Style
- `@State private var opacity` within the style struct
- Enables per-instance state for animations

### Gradient Background
- `LinearGradient` with multiple colors for modern look
- `.topLeading` to `.bottomTrailing` diagonal direction
- Applied to `RoundedRectangle` background

### Visual Styling
- `.foregroundStyle(.white)` for text/icon color
- `.shadow(radius:)` for depth effect
- Consistent padding with `.padding()`

## Key APIs
- `LabelStyle` protocol
- `makeBody(configuration:)`
- `configuration.title` / `configuration.icon`
- `.labelStyle()`
- `@State` in custom styles
- `onTapGesture`
- `DispatchQueue.main.asyncAfter()`
- `LinearGradient`
