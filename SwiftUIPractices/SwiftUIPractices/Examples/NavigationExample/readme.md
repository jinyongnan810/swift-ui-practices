# Navigation Example

Modern SwiftUI navigation patterns including NavigationStack, NavigationSplitView, and value-based navigation.

## Basic Navigation with Link

### NavigationLink Basics
- `NavigationLink("Title", destination: View())` for simple navigation
- Automatic back button and navigation bar

## Navigation With Value

### Type-Safe Navigation
- `NavigationLink("Title", value: recipe)` passes data
- `.navigationDestination(for: Type.self) { value in }` handles destination

### NavigationStack with Path
- `@State var path: [Recipe] = []` tracks navigation stack
- `NavigationStack(path: $path)` enables programmatic navigation
- Modifying `path` automatically updates navigation stack

### Path Observation
- `.onChange(of: path)` monitors navigation changes
- Useful for analytics or state synchronization

## NavigationSplitView

### Three-Column Layout
- `NavigationSplitView { sidebar } content: { list } detail: { detail }`
- Adaptive: collapses on compact widths

### Selection Binding
- `@State private var selectedCategory: Category?`
- `List(data, selection: $selection)` syncs selection
- `NavigationLink(value:)` updates selection

### Related Content
- Computed properties filter related items
- Callback pattern for detail-to-detail navigation

## NavigationSplitView With Value

### Combined Patterns
- Selection binding + value-based navigation
- Sidebar selection drives content list
- Content selection drives detail view

## Avoiding Nested NavigationStack

### Sheet-Based Separation
- Nested `NavigationStack` causes issues
- Use `.sheet()` to present separate navigation contexts
- Each sheet has independent navigation stack

## Key APIs
- `NavigationStack`
- `NavigationStack(path:)`
- `NavigationLink(value:)`
- `.navigationDestination(for:)`
- `NavigationSplitView`
- `List(selection:)`
- `.navigationTitle()`
- `.sheet()`
- `@State` for selection
