# Clock Practice

A dual clock display featuring both analog and digital time representations.

## Techniques & Tips

### TimelineView for Real-Time Updates
- `TimelineView(.animation)` for smooth analog clock hand movement (nanosecond precision)
- `TimelineView(.periodic(from:by:))` for digital clock updates every second
- Efficient way to handle time-based UI updates without manual timers

### Canvas Drawing (Analog Clock)
- SwiftUI `Canvas` for high-performance 2D drawing
- Direct drawing context manipulation for clock elements
- Trigonometric calculations for positioning clock hands and digits

### Clock Hand Calculations
- Angle calculation using `Double.pi * 2` divided by time units (60 for seconds/minutes, 12 for hours)
- Smooth second hand using nanosecond component for sub-second precision
- Different hand lengths (80%, 60%, 40% of radius) for visual hierarchy

### Path Drawing
- `Path` for drawing clock hands with custom stroke styles
- `StrokeStyle(lineWidth:lineCap:)` with `.round` for polished hand ends
- `ctx.fill()` and `ctx.stroke()` for rendering shapes

### Drawing Text on Canvas
- `ctx.draw(Text(...), at:)` for positioning hour digits
- Trigonometric positioning for circular text placement

### Tick Marks
- Loop through 60 positions for minute ticks
- `isMultiple(of: 5)` to differentiate hour tick marks (longer)

### Digital Clock Formatting
- `Date.formatted(date:time:)` for localized time display
- Monospaced font design for consistent digit width

## Key APIs
- `TimelineView`
- `Canvas`
- `GraphicsContext`
- `Path`
- `Calendar.component(_:from:)`
- `Date.formatted()`
- `LinearGradient`
