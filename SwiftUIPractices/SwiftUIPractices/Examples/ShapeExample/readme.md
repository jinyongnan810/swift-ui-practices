# Shape Example

Custom Shape implementations including animated star and wave shapes with Path drawing.

## Techniques & Tips

### Shape Protocol
- Implement `Shape` with `func path(in rect: CGRect) -> Path`
- `rect` provides bounds for drawing
- Return `Path` with drawing commands

### Path Drawing Commands
- `path.move(to:)` - start point
- `path.addLine(to:)` - straight line
- `path.addArc(center:radius:startAngle:endAngle:clockwise:)` - arc
- `path.addCurve(to:control1:control2:)` - bezier curve
- `path.closeSubpath()` - close shape

### Star Shape
- Trigonometric positioning for star points
- Alternating outer (full radius) and inner (half radius) points
- `sin()` and `cos()` calculate point positions
- Animatable `startAngle` parameter for rotation

### Wave Shape
- Bezier curve for smooth wave
- Control points determine wave shape
- Offset parameter for animation

### Shape as Clip Mask
- `.clipShape(StarShape(...))` clips image to star
- Animated shape parameter creates morphing effect

### Timer-Based Animation
- `Timer.publish(every:on:in:).autoconnect()` for continuous updates
- Update shape parameters on each tick
- Smooth animation through parameter interpolation

### CGPoint Extension
- Custom `+` operator for point addition
- Simplifies trigonometric calculations

### Gradient Fill
- `.fill(LinearGradient(...))` for gradient-filled shapes
- `.rotationEffect()` orients shape as needed

## Key APIs
- `Shape` protocol
- `Path`
- `path.move(to:)` / `addLine(to:)` / `addArc()` / `addCurve()`
- `.clipShape()`
- `Timer.publish()`
- Trigonometric functions (`sin`, `cos`)
- `CGPoint` arithmetic
