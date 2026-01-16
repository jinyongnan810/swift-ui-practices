# TextField Practice

Custom text field implementations with email validation and multiline support.

## Email Validation TextField

### Regex-Based Validation
- String extension `isValidEmail()` with regex pattern
- Pattern: `^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$`
- `range(of:options:.regularExpression)` for matching

### FocusState Management
- `@FocusState private var isFocused` tracks focus
- `.focused($isFocused)` binds focus to TextField
- Tap outside dismisses keyboard: `isFocused = false`

### Custom Placeholder
- Overlay with `Label` for icon + text placeholder
- `.allowsHitTesting(false)` prevents placeholder blocking input
- Conditional opacity based on text state and focus

### Keyboard Configuration
- `.keyboardType(.emailAddress)` for email keyboard
- `.autocorrectionDisabled()` prevents autocorrect
- `.textInputAutocapitalization(.none)` for lowercase

### Dynamic UI Feedback
- Title text changes based on input state
- Error message appears for invalid format
- Color changes indicate validation status

## Multiline TextField

### Axis-Based Expansion
- `TextField(text:axis:)` with `.vertical` axis
- TextField grows vertically as text wraps

### Submit Handling for Newlines
- `.onSubmit(of: .text)` captures return key
- Append newline and restore focus for continued editing
- Creates multiline input behavior

## Key APIs
- `TextField`
- `@FocusState`
- `.focused()`
- `.keyboardType()`
- `.textInputAutocapitalization()`
- `.onSubmit(of:)`
- String `range(of:options:.regularExpression)`
- `.overlay(alignment:)`
- `.allowsHitTesting()`
