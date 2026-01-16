# Sheet Practices

Collection of sheet presentation techniques including zoom transitions and dynamic height.

## Sheet Zoom Transition

### Matched Geometry Transition
- `@Namespace private var infoSpace` for transition coordination
- `.matchedTransitionSource(id:in:)` on source element (toolbar button)
- `.navigationTransition(.zoom(sourceID:in:))` on sheet content

### Presentation Detents
- `.presentationDetents([.medium, .large])` for multiple sheet sizes
- User can drag to switch between detent heights

### Toolbar Integration
- `ToolbarItem(placement: .primaryAction)` for button placement
- Sheet triggered from toolbar button with zoom animation

### Environment Dismiss
- `@Environment(\.dismiss)` for programmatic sheet dismissal
- Cancel button in sheet toolbar

## Sheet With Dynamic Height

### GeometryReader for Height Measurement
- Custom `GetHeightModifier` ViewModifier
- `GeometryReader` in background to measure content
- `DispatchQueue.main.async` to update height state safely

### Dynamic Presentation Detent
- `.presentationDetents([.height(sheetHeight)])` with state variable
- Sheet height matches content height exactly
- Alternative: `.fraction(0.8)` for percentage-based height

### Content Sizing
- `.fixedSize(horizontal: false, vertical: true)` constrains content
- Allows content to determine its natural height

## Key APIs
- `@Namespace`
- `.matchedTransitionSource()`
- `.navigationTransition(.zoom())`
- `.presentationDetents()`
- `.sheet(isPresented:)`
- `ViewModifier`
- `GeometryReader`
- `@Environment(\.dismiss)`
