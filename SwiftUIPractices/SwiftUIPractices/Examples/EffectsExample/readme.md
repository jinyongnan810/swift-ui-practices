# Effects Example

Visual effects including ripple shader, blur/blend modes, and gradient text masking.

## Ripple Effect

### Metal Shader Integration
- `ShaderLibrary.Ripple()` loads custom Metal shader
- Parameters: origin, elapsed time, amplitude, frequency, decay, speed

### LayerEffect with Visual Effect
- `.visualEffect { view, _ in view.layerEffect(...) }` applies shader
- `maxSampleOffset` limits pixel displacement
- `isEnabled` conditionally applies effect

### Keyframe-Driven Animation
- `.keyframeAnimator()` drives elapsed time
- `MoveKeyframe` and `LinearKeyframe` for timing
- Shader receives interpolated time values

### Custom Gesture for Touch Location
- `UIGestureRecognizerRepresentable` wraps `UILongPressGestureRecognizer`
- `minimumPressDuration = 0` for immediate response
- `CoordinateSpaceConverter` provides local coordinates

### SpatialPressingGesture
- Custom gesture that reports touch location
- `@Binding var location` updates on press
- Simultaneous gesture recognition enabled

## Blur & Blend Mode

### Blur Effect
- `.blur(radius:)` for Gaussian blur
- Adjustable with `Slider` for interactive demo

### Material Backgrounds
- `.ultraThinMaterial` for frosted glass effect
- Combines with blur for depth

### Blend Modes
- `.blendMode()` controls layer compositing
- Modes: `.plusLighter`, `.plusDarker`, `.softLight`, `.multiply`, `.screen`, `.overlay`, etc.
- Tap to cycle through blend modes

## Text with Gradient

### Gradient Masking
- `LinearGradient` as content
- `.mask { Text(...) }` clips gradient to text shape
- Random color changes on tap

## Key APIs
- `ShaderLibrary`
- `.visualEffect()`
- `.layerEffect()`
- `UIGestureRecognizerRepresentable`
- `.blur(radius:)`
- `.ultraThinMaterial`
- `.blendMode()`
- `.mask {}`
- `LinearGradient`
