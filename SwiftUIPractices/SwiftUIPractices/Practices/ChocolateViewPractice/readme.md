# Chocolate View Practice

A rotating text grid animation with gradient masking effect.

## Techniques & Tips

### Timer-Based Animation
- Uses `Timer.publish(every:on:in:).autoconnect()` for continuous rotation updates
- Timer fires every 0.1 seconds to create smooth animation

### Rotation Animation
- `rotationEffect()` with `.degrees()` for rotating the entire grid
- `.linear(duration:).repeatForever(autoreverses: false)` for continuous one-directional rotation
- Rotation angle increments by 5 degrees on each timer tick

### Gradient Masking
- `LinearGradient` as background with `.mask {}` modifier
- Two layered gradients: background gradient and masked foreground gradient
- Creates a colored text effect through the mask

### Grid Layout
- SwiftUI `Grid` and `GridRow` for organizing text elements
- Nested `ForEach` loops to create a 40x20 grid of "Chocolate" text
- `.fixedSize()` on text prevents text wrapping

### GeometryReader
- Used inside mask to get container dimensions
- Allows the grid to fill the available space dynamically

## Key APIs
- `Timer.publish(every:on:in:)`
- `LinearGradient`
- `.mask {}`
- `.rotationEffect()`
- `.animation(_:value:)`
- `Grid` / `GridRow`
- `GeometryReader`
