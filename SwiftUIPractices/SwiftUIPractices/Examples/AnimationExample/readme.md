# Animation Example

Comprehensive examples of SwiftUI animation techniques including SF Symbols, phase animations, keyframes, and transitions.

## SF Symbols Animation

### Symbol Effects
- `.symbolEffect(.bounce, value:)` - bounce animation on value change
- `.symbolEffect(.pulse, value:)` - pulsing animation
- `.symbolEffect(.variableColor.iterative)` - iterative color changes
- `.symbolEffect(.variableColor.cumulative)` - cumulative color changes
- `.symbolEffect(.wiggle)` - wiggle/shake animation
- `.symbolEffect(.rotate)` - rotation animation

### Effect Options
- `.options: .repeat(3)` - repeat animation specific times
- `.options: .speed(3)` - control animation speed
- `.options: .repeat(.continuous)` - continuous animation

### Symbol Rendering Modes
- `.symbolRenderingMode(.monochrome)` - single color
- `.symbolRenderingMode(.hierarchical)` - hierarchical coloring
- `.symbolRenderingMode(.multicolor)` - full multicolor

### Content Transition
- `.contentTransition(.symbolEffect(.replace.byLayer.downUp))` - animated symbol replacement

### Controlling Effects
- `.symbolEffectsRemoved()` - pause/remove effects conditionally

## Phase Animation

### Basic Phase Animation
- `.phaseAnimator([phases], trigger:)` for cycling through states
- Custom `AnimationProperties` struct with color and scale
- Enum-based phases with `CaseIterable` for automatic iteration

### Phase-Based Styling
- Apply different styles per phase (color, scale, background)
- Conditional overlays based on current phase

## Keyframe Animation

### KeyframeAnimator
- `.keyframeAnimator(initialValue:trigger:)` for complex multi-property animations
- Custom `AnimationValues` struct to hold animatable properties

### Keyframe Tracks
- `KeyframeTrack(\.property)` for each animatable property
- `LinearKeyframe` - linear interpolation
- `SpringKeyframe` - spring-based interpolation
- Control timing with `duration` parameter

### Multi-Track Coordination
- Animate scale and rotation simultaneously
- Different timing per track for complex effects

## Spring Animation Properties

### Which Spring Should You Choose?
- **Perceptual spring** - the best default for most interface animation. Choose it when designers describe motion in terms of speed and bounce, such as buttons, cards, sheets, and state changes.
- **Response-based spring** - choose it when maintaining or tuning code that already uses `response` and `dampingFraction`, or when you want direct control over critical damping behavior.
- **Physical spring** - choose it for simulations, gesture handoffs, or motion that must represent a specific mass, stiffness, damping, and starting velocity. It is more precise but harder to tune.
- Prefer the simplest model that expresses the intended motion. Different initializers are alternative ways to describe spring behavior, so combining all parameters is usually unnecessary.

### Perceptual Spring
- `duration` - controls the perceived pace of the spring
- `bounce` - controls overshoot, from overdamped negative values to highly bouncy positive values
- `blendDuration` - blends parameter changes when an active spring is replaced

### Response-Based Spring
- `response` - approximate duration that represents spring stiffness
- `dampingFraction` - damping relative to critical damping
- `blendDuration` - smooths changes between successive springs

### Physical Spring
- `mass` - weight attached to the spring
- `stiffness` - strength of the restoring force
- `damping` - friction that removes energy from the motion
- `initialVelocity` - starting velocity relative to the animated distance

## Transitions

### Built-in Transitions
- `.transition(.move(edge:))` - slide in/out
- `.transition(.slide)` - slide transition
- `.transition(.opacity)` - fade transition
- `.transition(.scale)` - scale transition

### Asymmetric Transitions
- `.transition(.asymmetric(insertion:removal:))` - different animations for appear/disappear

### Combined Transitions
- `.combined(with:)` to chain multiple transitions

### Custom Transitions
- `AnyTransition.modifier(active:identity:)` for custom ViewModifier-based transitions
- Custom `RotateScaleModifier` with rotation, scale, opacity, blur

## Key APIs
- `.symbolEffect()`
- `.symbolRenderingMode()`
- `.contentTransition()`
- `.phaseAnimator()`
- `.keyframeAnimator()`
- `KeyframeTrack`
- `LinearKeyframe` / `SpringKeyframe`
- `.transition()`
- `AnyTransition`
