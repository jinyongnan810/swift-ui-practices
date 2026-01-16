# Segmented Border Practice

Animated segmented border using capsule shapes with blur effects and colored segments.

## Techniques & Tips

### Shape Trimming
- `Capsule().trim(from:to:)` creates partial shape segments
- Calculate segment size: `1 / Double(numberOfPeople)`
- Each segment occupies equal portion of the shape perimeter

### Blur Glow Effect
- `.blur(radius: 15)` on stroked segments creates glow
- Layered approach: blurred background + sharp foreground dots

### Segment Positioning
- Calculate start position: `Double(i) * sizeForEach`
- Calculate middle position for dots: `start + sizeForEach / 2`
- Small trim range (0.01) creates dot effect at segment boundaries

### StrokeStyle Configuration
- `StrokeStyle(lineWidth:lineCap:lineJoin:)` for custom stroke appearance
- `.round` line cap for smooth segment ends

### Color Cycling
- `colors[i % colors.count]` cycles through color array
- Modulo ensures no index out of bounds

### Layered ZStack
- Background: semi-transparent capsule fill
- Middle layer: blurred colored segments
- Top layer: sharp colored dots at segment boundaries

## Key APIs
- `Capsule()`
- `.trim(from:to:)`
- `.stroke(_:lineWidth:)`
- `StrokeStyle`
- `.blur(radius:)`
- `ZStack` layering
- `ForEach` with index
- Modulo operator for color cycling
