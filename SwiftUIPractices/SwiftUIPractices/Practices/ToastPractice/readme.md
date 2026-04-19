# Toast Practice

Toast notifications driven by environment actions instead of local bindings.

## Techniques & Tips

### Toast Model
- `Toast` stores the message text, SF Symbol name, optional action, and dismiss duration.
- `Toast.Action` carries the button title and handler used by interactive toasts.

### Environment-Driven API
- `EnvironmentValues.showToast` exposes a `ShowToastAction`.
- `EnvironmentValues.dismissToast` exposes a `DismissToastAction`.
- Child views can present or dismiss a toast without owning overlay state.

### Wrapper View
- `ToastWrapper` accepts the main content and layers the toast as a bottom overlay.
- The wrapper owns current and pending toast state plus dismissal tasks.
- When a new toast arrives, the current one animates out first, then the new one is shown.

### Toast Presentation
- `ToastView` renders as a capsule using SwiftUI Liquid Glass via `.glassEffect(..., in: Capsule())`.
- The overlay uses an offset + opacity transition from the bottom edge.
- Automatic dismissal is implemented with `Task.sleep(for:)` and cancellation.

### Example Screen
- `Add To Cart` shows a success toast with an `Undo` action.
- `Show Notification` shows an informational toast with no action.
- `Dismiss Current Toast` immediately hides any visible toast.
