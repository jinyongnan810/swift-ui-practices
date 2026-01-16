# Swipe Actions Practice

List with swipe actions, multi-selection, and edit mode support.

## Techniques & Tips

### Swipe Actions
- `.swipeActions {}` modifier on list rows
- Multiple actions: delete (destructive) and star/mark
- `role: .destructive` for red delete button styling
- `.tint()` for custom action button colors

### List Selection
- `List(data, selection: $selections)` enables selection mode
- `Set<TestDataItem>` for multi-selection storage
- `.tag(item)` associates row with selection value

### Edit Mode
- `@Environment(\.editMode)` for edit state access
- `EditButton()` in toolbar toggles edit mode
- `editMode?.wrappedValue = .inactive` to exit programmatically

### Conditional Toolbar Items
- `if !selections.isEmpty` shows delete button only when items selected
- Dynamic button text: `"Delete \(selections.count) items"`
- `placement: .bottomBar` for bottom toolbar positioning

### Data Model
- `Identifiable` for list iteration
- `Hashable` for Set-based selection
- `mutating func toggleMarked()` for state changes

### Animated Data Mutations
- `withAnimation {}` wraps array modifications
- Smooth item removal and marking animations
- `removeAll(where:)` for filtered deletion

## Key APIs
- `.swipeActions {}`
- `Button` with `role: .destructive`
- `List(selection:)`
- `Set<Item>`
- `.tag()`
- `@Environment(\.editMode)`
- `EditButton()`
- `ToolbarItem(placement:)`
- `withAnimation`
