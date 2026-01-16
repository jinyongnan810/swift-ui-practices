# Flip Card Practice

A 3D flip card animation with front and back sides.

## Techniques & Tips

### 3D Rotation Effect
- `.rotation3DEffect()` for realistic card flip
- Rotate around Y-axis: `axis: (x: 0, y: 1, z: 0)`
- `perspective: 0.8` adds depth to the rotation

### Back Side Pre-Rotation
- Back side pre-rotated 180 degrees: `.rotation3DEffect(.degrees(180), ...)`
- Ensures text appears correctly (not mirrored) when flipped

### Opacity-Based Side Switching
- Computed properties for `sideAOpacity` and `sideBOpacity`
- Opacity transitions from 0 to 1 during flip
- Simpler alternative to zIndex management (commented code shows zIndex approach)

### Animation Coordination
- Single `isFlipped` state controls both sides
- `.animation(.easeInOut, value:)` for smooth transitions
- Tap gesture toggles flip state with `withAnimation`

### Card Styling
- Fixed frame size for consistent card dimensions
- `.clipShape(.rect(cornerRadius:))` for rounded corners
- `.shadow()` for depth effect

### Gradient Backgrounds
- Different `LinearGradient` colors for each side
- Visual distinction between front and back

## Key APIs
- `.rotation3DEffect(_:axis:perspective:)`
- `.degrees()`
- `.opacity()`
- `.animation(_:value:)`
- `onTapGesture`
- `withAnimation`
- `LinearGradient`
- `.clipShape()`
