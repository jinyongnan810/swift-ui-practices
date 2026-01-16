# Gauge Practice

Demonstrates various SwiftUI Gauge styles with dynamic value and color-based indicators.

## Techniques & Tips

### Built-in Gauge Styles
- `.accessoryCircularCapacity` - circular with fill indicator
- `.accessoryCircular` - circular with needle
- `.accessoryLinear` - horizontal bar
- `.accessoryLinearCapacity` - horizontal bar with fill
- `.linearCapacity` - full-width linear gauge

### Gauge Configuration
- Value range: `Gauge(value:in:)` with min/max bounds
- Label, currentValueLabel, minimumValueLabel, maximumValueLabel
- Comprehensive display of gauge information

### Dynamic Tint Based on Value
- Ternary chain for color thresholds: `value < 33 ? .blue : value < 66 ? .yellow : .red`
- Visual feedback for temperature zones (cold/warm/hot)

### Animated Value Changes
- `.animation(.linear(duration:), value:)` on gauge
- Smooth transitions when slider value changes

### Interactive Slider Control
- `Slider(value:in:)` bound to gauge value
- Real-time gauge updates as slider moves

### List Layout
- `Section` for grouping related gauges
- Clean organization with header text

## Key APIs
- `Gauge`
- `.gaugeStyle()`
- `.tint()`
- `Slider`
- `@State`
- `.animation(_:value:)`
- `List` / `Section`
