# Mesh Gradient Example

Animated mesh gradient with dynamic control point movement.

## Techniques & Tips

### MeshGradient Basics
- `MeshGradient(width:height:points:colors:)` creates a color mesh
- `width` and `height` define grid dimensions (3x3 = 9 points)
- Points use `SIMD2<Float>` with normalized coordinates (0...1)

### Grid Point Layout
- Points arranged in row-major order
- 3x3 grid: top-left (0,0) to bottom-right (1,1)
- Each point has corresponding color

### Animated Control Points
- Timer updates center point position randomly
- `points[4]` is the center of 3x3 grid
- Random values: `Float.random(in: 0...1)`

### Timer-Based Animation
- `Timer.publish(every:on:in:).autoconnect()` for continuous updates
- `.onReceive(timer)` triggers point updates
- Animation smooths transitions between positions

### Smooth Animation
- `.animation(.linear(duration:).repeatForever(autoreverses: false), value:)`
- Long duration (5s) for smooth morphing effect
- `autoreverses: false` for continuous flow

### Color Array
- 9 colors map to 9 grid points
- Colors blend between adjacent points
- Creates organic, flowing gradients

## Key APIs
- `MeshGradient`
- `SIMD2<Float>`
- `Timer.publish(every:on:in:)`
- `.autoconnect()`
- `.onReceive()`
- `.animation(_:value:)`
- `Float.random(in:)`
