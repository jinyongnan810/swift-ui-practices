# Observation Example

Modern state management with `@Observable` macro (iOS 17+) and environment injection.

## Techniques & Tips

### @Observable Macro
- `@Observable class ViewModel` for reactive classes
- Properties automatically trigger view updates
- Replaces `ObservableObject` + `@Published` pattern

### @State with Observable
- `@State var viewModel = ViewModel()` preserves instance across redraws
- Without `@State`, viewModel reinitializes when parent updates
- Critical for maintaining state lifetime

### Environment Injection
- `.environment(viewModel)` injects into view hierarchy
- `@Environment(ViewModel.self)` retrieves in child views
- Type-based lookup (no key required)

### @Bindable for Two-Way Binding
- `@Bindable var bindable = viewModel` inside view body
- Enables `$bindable.property` for TextField binding
- Required because `@Environment` doesn't provide binding directly

### Comparison with Legacy Pattern
- Old: `ObservableObject`, `@Published`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject`
- New: `@Observable`, `@State`, `@Environment`
- Simpler mental model, less boilerplate

## Usage Pattern

```swift
// Define observable class
@Observable
class MyViewModel {
    var data: String = ""
}

// Parent view
struct ParentView: View {
    @State var viewModel = MyViewModel()
    var body: some View {
        ChildView()
            .environment(viewModel)
    }
}

// Child view
struct ChildView: View {
    @Environment(MyViewModel.self) var viewModel
    var body: some View {
        @Bindable var vm = viewModel
        TextField("", text: $vm.data)
    }
}
```

## Key APIs
- `@Observable` macro
- `@State` (for Observable classes)
- `.environment()`
- `@Environment(Type.self)`
- `@Bindable`
