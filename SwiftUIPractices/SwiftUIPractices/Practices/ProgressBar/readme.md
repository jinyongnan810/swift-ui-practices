# Progress Bar Practice

Custom progress bar with dynamic corner radius calculations for smooth edges.

## Techniques & Tips

### Dynamic Corner Radius Calculation
- Left corner radius adjusts when progress is less than cornerRadius
- Uses Pythagorean theorem: `sqrt(b*b - a*a) * 2` for height calculation
- Right corner radius transitions smoothly as progress increases

### Progress Bar Geometry
- Fixed outer dimensions with `width` and `height` constants
- `progressWidth` computed from progress percentage
- `progressHeight` adjusts for small progress values (circular cap effect)

### Gradient Fill
- `LinearGradient` from blue to red along progress direction
- Applied to progress indicator, not the track

### RectangleCornerRadii
- `.rect(cornerRadii:)` shape with individual corner control
- `topLeading`, `bottomLeading`, `topTrailing`, `bottomTrailing`
- Different radii for left (fixed) and right (dynamic) sides

### Overlay Alignment
- `.overlay(alignment: .leading)` positions progress from left
- Progress bar sits inside the track container

### Interactive Slider
- `Slider(value:in:)` for real-time progress adjustment
- Range 0...1 for percentage-based progress

## Key APIs
- `RoundedRectangle`
- `.rect(cornerRadii: RectangleCornerRadii(...))`
- `.overlay(alignment:)`
- `LinearGradient`
- `.clipShape()`
- `Slider`
- Computed properties with geometry math
