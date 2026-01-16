# Custom View Modifier Example

Demonstrates creating reusable ViewModifiers with View extensions for clean, composable code.

## Techniques & Tips

### ViewModifier Protocol
- Implement `ViewModifier` with `func body(content: Content) -> some View`
- `content` parameter represents the view being modified
- Return modified view with additional styling/behavior

### Parameterized Modifiers
- Add properties to ViewModifier struct for configuration
- `init(alignment: Alignment = .center)` with default values
- Reusable across different use cases

### View Extension Pattern
- `extension View { func align(...) -> some View }` for fluent API
- `modifier(AlignViewModifier(alignment:))` internally
- Cleaner call sites: `.align(.topLeading)` vs `.modifier(AlignViewModifier(alignment: .topLeading))`

### Alignment Helper
- `AlignViewModifier` positions views within available space
- Uses `.frame(maxWidth: .infinity, maxHeight: .infinity, alignment:)`
- Supports all 9 alignment positions

## Usage Patterns

```swift
// Using modifier directly
Text("Hello").modifier(AlignViewModifier(alignment: .topLeading))

// Using View extension (preferred)
Text("Hello").align(.topLeading)
```

## Key APIs
- `ViewModifier` protocol
- `func body(content: Content) -> some View`
- `.modifier()`
- `extension View`
- `.frame(maxWidth:maxHeight:alignment:)`
