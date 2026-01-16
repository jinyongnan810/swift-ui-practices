# Gestures Example

Comprehensive gesture handling including magnification, drag, rotation, and simultaneous gestures.

## Magnification Gesture

### Basic Magnification
- `MagnificationGesture()` for pinch-to-zoom
- `.onChanged { value in }` receives scale factor
- `.onEnded { _ in }` for completion handling

### State Patterns
- "Stay Still": Maintains scale after gesture ends
- "Bounce Back": Animates back to original scale
- "State Stored": Persists scale across view appearances via `@Binding`

## Drag Gesture

### Offset Tracking
- Track both current and ended offset separately
- Combine for total offset: `offsetEnded + offsetCurrent`
- Reset `offsetCurrent` to `.zero` on gesture end

### Drag Patterns
- "Stay Still": Position persists after drag
- "Bounce Back": Animates to origin with `withAnimation`
- "Stored State": Maintains position across navigation

### Reset on Tap
- `onTapGesture` resets position to origin
- Wrap in `withAnimation` for smooth reset

## Rotation Gesture

### Angle Tracking
- `RotateGesture()` provides rotation angle
- Combine current + ended rotation for total
- `value.rotation` gives `Angle` type

### Applied with rotationEffect
- `.rotationEffect(angle)` applies rotation
- Separate tracking for incremental rotation

## Simultaneous Gestures

### Combining Multiple Gestures
- `SimultaneousGesture(gesture1, gesture2)` allows concurrent handling
- Nest for 3+ gestures: `SimultaneousGesture(SimultaneousGesture(drag, magnify), rotate)`

### Multi-Transform Example
- Drag, magnification, and rotation together
- Each gesture updates its own state
- Combined result: draggable, scalable, rotatable view

## @GestureState

### Auto-Reset Behavior
- `@GestureState` automatically resets when gesture ends
- `.updating($state) { value, state, _ in state = value }`
- Simpler than manual state management for bounce-back behavior

### Spring Animation
- `.animation(.spring, value:)` animates state changes
- Smooth return to initial value

## Key APIs
- `MagnificationGesture`
- `DragGesture`
- `RotateGesture`
- `SimultaneousGesture`
- `@GestureState`
- `.gesture()`
- `.onChanged` / `.onEnded`
- `.updating()`
- `.scaleEffect()`
- `.offset()`
- `.rotationEffect()`
