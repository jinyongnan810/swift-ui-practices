# TabView Example

Modern TabView with Tab API, customization, and sidebar-adaptable style.

## Techniques & Tips

### Tab API (iOS 18+)
- `Tab("Title", systemImage: "icon", value: .enumCase) { content }`
- Type-safe tab selection with enum
- Cleaner syntax than older `tabItem` approach

### Tab Selection
- `@State private var selectedTab: TabType`
- `TabView(selection: $selectedTab)` binds selection
- Enum-based for type safety

### Search Tab Role
- `Tab(value: .search, role: .search) { content }`
- Special search tab with system behavior
- Adapts to platform conventions

### TabViewCustomization
- `@State var customization = TabViewCustomization()`
- `.tabViewCustomization($customization)` enables user customization
- `.customizationID("com.myApp.TabName")` identifies tabs

### Sidebar Adaptable Style
- `.tabViewStyle(.sidebarAdaptable)` adapts to screen size
- Shows as sidebar on iPad, tabs on iPhone
- Automatic adaptation

### Selection Change Observation
- `.onChange(of: selectedTab) { previous, next in }` monitors tab changes
- Useful for analytics or state updates

### TabSection (Grouped Tabs)
- `TabSection("Group Name") { tabs }` groups related tabs
- Note: May have compatibility issues with selection binding

## Key APIs
- `TabView`
- `Tab` (iOS 18+)
- `TabView(selection:)`
- `.tabViewStyle(.sidebarAdaptable)`
- `TabViewCustomization`
- `.tabViewCustomization()`
- `.customizationID()`
- `Tab(role: .search)`
