# Toast Practice

Toast notification system with custom ViewModifier and automatic dismissal.

## Techniques & Tips

### Custom ViewModifier
- `MyToastModifier` implements `ViewModifier` protocol
- `func body(content: Content)` wraps original content
- Adds toast overlay to any view

### View Extension for Clean API
- `extension View { func toast(...) }` for fluent syntax
- Usage: `.toast(text: "Message", isShowing: $showToast)`
- Encapsulates modifier creation

### Auto-Dismiss with onChange
- `.onChange(of: isShowing)` monitors state changes
- `DispatchQueue.main.asyncAfter()` for delayed dismissal
- Only triggers when transitioning to `true`

### Animated Offset Transition
- Toast slides up from bottom using `.offset(y:)`
- Computed `offset`: 0 when showing, 100 when hidden
- `withAnimation` wraps state toggle for smooth animation

### Toast View Styling
- Horizontal and vertical padding for content
- Black gradient background for modern look
- Rounded corners with `.cornerRadius()`
- `.frame(maxHeight: .infinity, alignment: .bottom)` positions at bottom

### Binding for External Control
- `@Binding var isShowing` allows parent to control visibility
- Parent can show toast, modifier handles auto-hide

## Key APIs
- `ViewModifier` protocol
- `func body(content: Content)`
- View extension for custom modifiers
- `.onChange(of:)`
- `.offset()`
- `@Binding`
- `DispatchQueue.main.asyncAfter()`
- `withAnimation`
- `.frame(alignment:)`
