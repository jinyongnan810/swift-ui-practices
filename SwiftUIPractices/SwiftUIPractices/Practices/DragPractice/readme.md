# Drag Practice

A draggable grid of icons with shuffle animation and visual feedback.

## Techniques & Tips

### DragGesture Implementation
- `DragGesture()` with `.onChanged` and `.onEnded` handlers
- Track translation with `value.translation`
- Animate return to original position with `withAnimation`

### zIndex Management
- Dynamic `zIndex` to bring dragged item to front
- Prevents dragged item from appearing behind siblings
- Reset zIndex after animation completes

### Visual Drag Feedback
- `.opacity(0.9)` when dragging for slight transparency
- `.scaleEffect(1.2)` to enlarge dragged item
- `.offset()` to follow finger position

### Tap Gesture with Glow Effect
- Tap triggers border glow animation
- `.blur(radius: 5)` on stroke for glow effect
- Color changes randomly on tap

### Data Model Design
- `Identifiable` and `Equatable` conformance for list/grid usage
- Multiple initializers for flexibility
- Random color assignment on initialization

### Grid Layout
- `Grid` and `GridRow` for organized layout
- 2D array data structure matches visual grid
- Nested `ForEach` with index-based binding

### Shuffle Animation
- `.shuffled()` on both rows and items within rows
- `withAnimation` wraps data mutation for smooth transitions

## Key APIs
- `DragGesture`
- `.onChanged` / `.onEnded`
- `.offset()`
- `.zIndex()`
- `.scaleEffect()`
- `@Binding`
- `Grid` / `GridRow`
- `.shuffled()`
- `withAnimation`
